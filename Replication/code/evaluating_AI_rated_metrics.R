
###############################################################################################
# Correllations across Prompts
###############################################################################################
d5 = df[which(df$LeyoTextoA == "SI" & df$CompletoTextoA == "SI" & df$LeyoTextoB == "SI" & df$CompletoTextoB == "SI" & df$RateA<7 & df$RateB<7),]

d5$Site = d5$Esitio
d5$Site[which(d5$Site=="BS")] = "Coastal"
d5$Site[which(d5$Site=="SC")] = "Lowland"
d5 = d5[which(d5$Site %in% c("Coastal", "Lowland")),]


# Quick regressions
reg_r1 = summary(lm(RateB_auto ~ RateA_auto, data=d5))
reg_r2 = summary(lm(TrueRateB_auto ~ TrueRateA_auto, data=d5))
reg_b = summary(lm(BalanceB_auto ~ BalanceA_auto, data=d5))
reg_es = summary(lm(ExcessSyllablesB_auto ~ ExcessSyllablesA_auto, data=d5))
reg_p = summary(lm(PausesB_auto ~ PausesA_auto, data=d5))

outcomes_1 = matrix(NA,nrow=5, ncol=5)

outcomes_1[1,] = make_res(reg_r1, "Reading rate, B", "Reading rate, A")
outcomes_1[2,] = make_res(reg_r2, "Reading rate *, B", "Reading rate *, A")
outcomes_1[3,] = make_res(reg_b,  "Balance, B", "Balance, A")
outcomes_1[4,] = make_res(reg_es, "Repetition score, B", "Repetition score, A")
outcomes_1[5,] = make_res(reg_p,  "Pause rate, B", "Pause rate, A")

xtable(outcomes_1)


######### Merge across prompts
d5$reading_rate_avg = rowMeans(d5[,which(colnames(d5) %in% c("RateA","RateB"))],na.rm=TRUE)
d5$error_rate_avg = rowMeans(d5[,which(colnames(d5) %in% c("ErrorA","ErrorB"))],na.rm=TRUE)
d5$score_avg = rowMeans(d5[,which(colnames(d5) %in% c("ScoreA", "ScoreB"))],na.rm=TRUE)

d5$auto_reading_rate_avg = rowMeans(d5[,which(colnames(d5) %in% c("RateA_auto","RateB_auto"))],na.rm=TRUE)
d5$auto_true_reading_rate_avg = rowMeans(d5[,which(colnames(d5) %in% c("TrueRateA_auto","TrueRateB_auto"))],na.rm=TRUE)
d5$auto_balance_avg = rowMeans(d5[,which(colnames(d5) %in% c("BalanceA_auto", "BalanceB_auto"))],na.rm=TRUE)
d5$auto_excess_syllables_avg = rowMeans(d5[,which(colnames(d5) %in% c("ExcessSyllablesA_auto", "ExcessSyllablesB_auto"))],na.rm=TRUE)
d5$auto_pauses_avg = rowMeans(d5[,which(colnames(d5) %in% c("PausesA_auto", "PausesB_auto"))],na.rm=TRUE)

######### Regression

reg2_rate_edu = summary(lm(auto_reading_rate_avg ~ EducationYears, data=d5))
reg2_rate2_edu = summary(lm(auto_true_reading_rate_avg ~ EducationYears, data=d5))
reg2_bal_edu = summary(lm(auto_balance_avg ~ EducationYears, data=d5))
reg2_excess_edu = summary(lm(auto_excess_syllables_avg ~ EducationYears, data=d5))
reg2_pauses_edu = summary(lm(auto_pauses_avg ~ EducationYears, data=d5))

reg2_rate_age = summary(lm(auto_reading_rate_avg ~ Age, data=d5))
reg2_rate2_age = summary(lm(auto_true_reading_rate_avg ~ Age, data=d5))
reg2_bal_age = summary(lm(auto_balance_avg ~ Age, data=d5))
reg2_excess_age = summary(lm(auto_excess_syllables_avg ~ Age, data=d5))
reg2_pauses_age = summary(lm(auto_pauses_avg ~ Age, data=d5))

reg2_rate_score = summary(lm(auto_reading_rate_avg ~ score_avg, data=d5))
reg2_rate2_score = summary(lm(auto_true_reading_rate_avg ~ score_avg, data=d5))
reg2_bal_score = summary(lm(auto_balance_avg ~ score_avg, data=d5))
reg2_excess_score = summary(lm(auto_excess_syllables_avg ~ score_avg, data=d5))
reg2_pauses_score = summary(lm(auto_pauses_avg ~ score_avg, data=d5))

reg2_rate_rate = summary(lm(auto_reading_rate_avg ~ reading_rate_avg, data=d5))
reg2_rate2_rate = summary(lm(auto_true_reading_rate_avg ~ reading_rate_avg, data=d5))
reg2_bal_rate = summary(lm(auto_balance_avg ~ reading_rate_avg, data=d5))
reg2_excess_rate = summary(lm(auto_excess_syllables_avg ~ reading_rate_avg, data=d5))
reg2_pauses_rate = summary(lm(auto_pauses_avg ~ reading_rate_avg, data=d5))

reg2_rate_err = summary(lm(auto_reading_rate_avg ~ error_rate_avg, data=d5))
reg2_rate2_err = summary(lm(auto_true_reading_rate_avg ~ error_rate_avg, data=d5))
reg2_bal_err = summary(lm(auto_balance_avg ~ error_rate_avg, data=d5))
reg2_excess_err = summary(lm(auto_excess_syllables_avg ~ error_rate_avg, data=d5))
reg2_pauses_err = summary(lm(auto_pauses_avg ~ error_rate_avg, data=d5))


outcomes_3 = matrix(NA,nrow=25, ncol=5)

outcomes_3[1,] = make_res(reg2_rate_edu, "Reading rate", "Education")
outcomes_3[2,] = make_res(reg2_rate2_edu, "Reading rate *", "Education")
outcomes_3[3,] = make_res(reg2_bal_edu, "Balance score", "Education")
outcomes_3[4,] = make_res(reg2_excess_edu, "Repetition score", "Education")
outcomes_3[5,] = make_res(reg2_pauses_edu, "Pause rate", "Education")

outcomes_3[1+5,] = make_res(reg2_rate_age, "Reading rate", "Age")
outcomes_3[2+5,] = make_res(reg2_rate2_age, "Reading rate *", "Age")
outcomes_3[3+5,] = make_res(reg2_bal_age, "Balance score", "Age")
outcomes_3[4+5,] = make_res(reg2_excess_age, "Repetition score", "Age")
outcomes_3[5+5,] = make_res(reg2_pauses_age, "Pause rate", "Age")

outcomes_3[1+10,] = make_res(reg2_rate_score, "Reading rate", "Likert score")
outcomes_3[2+10,] = make_res(reg2_rate2_score, "Reading rate *", "Likert score")
outcomes_3[3+10,] = make_res(reg2_bal_score, "Balance score", "Likert score")
outcomes_3[4+10,] = make_res(reg2_excess_score, "Repetition score", "Likert score")
outcomes_3[5+10,] = make_res(reg2_pauses_score, "Pause rate", "Likert score")

outcomes_3[1+15,] = make_res(reg2_rate_rate, "Reading rate", "Reading rate")
outcomes_3[2+15,] = make_res(reg2_rate2_rate, "Reading rate *", "Reading rate")
outcomes_3[3+15,] = make_res(reg2_bal_rate, "Balance score", "Reading rate")
outcomes_3[4+15,] = make_res(reg2_excess_rate, "Repetition score", "Reading rate")
outcomes_3[5+15,] = make_res(reg2_pauses_rate, "Pause rate", "Reading rate")

outcomes_3[1+20,] = make_res(reg2_rate_err, "Reading rate", "Error rate")
outcomes_3[2+20,] = make_res(reg2_rate2_err, "Reading rate *", "Error rate")
outcomes_3[3+20,] = make_res(reg2_bal_err, "Balance score", "Error rate")
outcomes_3[4+20,] = make_res(reg2_excess_err, "Repetition score", "Error rate")
outcomes_3[5+20,] = make_res(reg2_pauses_err, "Pause rate", "Error rate")

##################################### PCA
d6 = d5[,c("auto_reading_rate_avg", "auto_true_reading_rate_avg", "auto_balance_avg", "auto_excess_syllables_avg", "auto_pauses_avg" )]
d5b = d5[complete.cases(d6),]
d6b = d6[complete.cases(d6),]

pc = prcomp(d6b,
             center = TRUE,
            scale. = TRUE)
attributes(pc)

summary(pc)
print(pc)

d7 = cbind(d5b,pc$x)


################################## Contrasting predictions
# First dredge to find by 2 param models
d8 = d7[which(!is.na(d7$EducationYears) & !is.na(d7$score_avg)),]

globalmodel_edu = lm(EducationYears ~ auto_reading_rate_avg + auto_true_reading_rate_avg + auto_balance_avg + auto_excess_syllables_avg + auto_pauses_avg, data = d8)
globalmodel_edu = lm(score_avg ~ auto_reading_rate_avg + auto_true_reading_rate_avg + auto_balance_avg + auto_excess_syllables_avg + auto_pauses_avg, data = d8)

options(na.action = "na.fail")
combinations_edu = dredge(globalmodel_edu)
combinations_score = dredge(globalmodel_edu)

print(combinations_edu)
print(combinations_score)


# Now compare 
options(na.action = "na.omit")
s1 = (lm(EducationYears ~ auto_reading_rate_avg + auto_balance_avg, data=d7))
s1b = (lm(score_avg ~ auto_reading_rate_avg + auto_balance_avg, data=d7))

s2 = (lm(EducationYears ~ PC1 + PC2, data=d7))
s2b = (lm(score_avg ~ PC1 + PC2, data=d7))

s3 = (lm(EducationYears ~ reading_rate_avg + error_rate_avg, data=d7))
s3b = (lm(score_avg ~ reading_rate_avg + error_rate_avg, data=d7))

stargazer(s1, s2, s3,  p.auto = FALSE, omit = "Constant", single.row=TRUE)
stargazer(s1b, s2b, s3b,  p.auto = FALSE, omit = "Constant", single.row=TRUE)

         
############# Plotting education and scores
df5_new = data.frame(
 Outcome = c(d5$auto_reading_rate_avg, d5$auto_reading_rate_avg, d5$auto_true_reading_rate_avg, d5$auto_true_reading_rate_avg, d5$auto_pauses_avg, d5$auto_pauses_avg, d5$auto_excess_syllables_avg, d5$auto_excess_syllables_avg, d5$auto_balance_avg, d5$auto_balance_avg),
 Predictor = c(d5$EducationYears, d5$Age, d5$EducationYears, d5$Age, d5$EducationYears, d5$Age, d5$EducationYears, d5$Age, d5$EducationYears, d5$Age),
 Site = rep(d5$Site, 10),
 Metric=rep(c("Reading rate (syllables/sec)","Reading rate (syllables/sec)",
 	"Reading rate* (syllables/sec)","Reading rate* (syllables/sec)",
 	 "Pause rate (events/10-syll.)","Pause rate (events/10-syll.)",
 	 "Repetition rate (events/syll.)","Repetition rate (events/syll.)",
 	 "Speaking balance","Speaking balance"),
 each=length(d5$score_avg)),
 Covariate=rep(c("Education (Years)","Age","Education (Years)","Age","Education (Years)","Age","Education (Years)","Age","Education (Years)","Age"),each=length(d5$score_avg))
 )

p5 = ggplot(df5_new, aes(x=Predictor, y=Outcome, color=Site, group=Site)) +
  geom_jitter(height=0.1) +  facet_grid(Metric~Covariate,scales="free") +
  scale_color_manual(values=c("Coastal" ="#3187cf", "Lowland" ="#cf7931")) + #geom_smooth(method = 'lm', formula = y ~ splines::bs(x, degree=7), aes(fill = after_scale(color)), alpha = 0.2) +
  theme(legend.position="bottom") + xlab(" ") + ylab(" ")


ggsave("Fig_AgeEdu_RateScore_Auto.pdf",p5, width=6, height=10)


summary(lm(reading_rate_avg ~ EducationYears, data=d4))



