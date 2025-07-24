# Load necessary libraries
install.packages("randomForest")
library(randomForest)
library(dplyr)
library(readr)

# Set seed for reproducibility
set.seed(123)

#import raw data from consumer goods client
cg_df <- read_csv("raw data/consumer_goods_modeling_data.csv")

#describe summary stats of data
psych::describe(cg_df)

#display formats of all columns in data
str(cg_df)

#display frequencies of some columns 
table(cg_df$Season)
table(cg_df$OnTimeInFull)

# Convert categorical variables
cg_df$Season <- as.factor(cg_df$Season)
cg_df$OnTimeInFull <- as.factor(cg_df$OnTimeInFull)

# -------------------------------
# Model 1: Predict On-Time In-Full Delivery
# -------------------------------
rf_otif <- randomForest(OnTimeInFull ~ OrderSize + LeadTime + SupplierScore + Season,
                        data = cg_df, ntree = 100)
importance_otif <- importance(rf_otif)
pred_otif <- predict(rf_otif, cg_df)

# -------------------------------
# Model 2: Predict Inventory Level
# -------------------------------
rf_inventory <- randomForest(InventoryLevel ~ InventoryTurnover + OrderSize + LeadTime + SupplierScore,
                             data = cg_df, ntree = 100)
importance_inventory <- importance(rf_inventory)
pred_inventory <- predict(rf_inventory, cg_df)

# -------------------------------
# Model 3: Predict Marketing ROI
# -------------------------------
rf_roi <- randomForest(MarketingROI ~ PromoSpend + Season + OrderSize,
                       data = cg_df, ntree = 100)
importance_roi <- importance(rf_roi)
pred_roi <- predict(rf_roi, cg_df)

# -------------------------------
# Prepare output for Power BI
# -------------------------------
# Add predictions back to the original data
data_output <- cg_df %>%
  mutate(
    Pred_OTIF = pred_otif,
    Pred_Inventory = pred_inventory,
    Pred_ROI = pred_roi
  )

# Export results and variable importance to CSV
write_csv(data_output, "output/model_predictions_output.csv")
write_csv(as.data.frame(importance_otif), "output/importance_otif.csv")
write_csv(as.data.frame(importance_inventory), "output/importance_inventory.csv")
write_csv(as.data.frame(importance_roi), "output/importance_roi.csv")

# Message
cat("Model training complete. Results exported for Power BI dashboard.\n")
