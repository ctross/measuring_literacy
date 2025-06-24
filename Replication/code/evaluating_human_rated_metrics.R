
# Syllable per minute
d3 = df[which(df$RateA<7 & df$RateB<7),]

d3_a = d3[which(d3$LeyoTextoA == "SI" & d3$CompletoTextoA == "SI"),]
d3_b = d3[which(d3$LeyoTextoB == "SI" & d3$CompletoTextoB == "SI"),]

d3_A = data.frame(Site = c(d3_a$Esitio), Prompt = rep(c("Prompt A"), each=length(d3_a$Esitio)), Score = c(d3_a$ScoreA), Rate=c(d3_a$RateA))
d3_B = data.frame(Site = c(d3_b$Esitio), Prompt = rep(c("Prompt B"), each=length(d3_b$Esitio)), Score = c(d3_b$ScoreB), Rate=c(d3_b$RateB))

df3_new = rbind(d3_A, d3_B)

df3_new$Site[which(df3_new$Site=="BS")] = "Coastal"
df3_new$Site[which(df3_new$Site=="SC")] = "Lowland"

p2 = ggplot(df3_new, aes(x=Rate, y=Score, color=Site, group=Site)) +
  geom_jitter() +  facet_wrap(vars(Prompt),nrow=2) + 
  scale_color_manual(values=c("Coastal" ="#3187cf", "Lowland" ="#cf7931")) + 
  theme(legend.position="bottom") + xlab("Reading rate (syllables per second)") + ylab("Reading score (Likert scale)")

print(p2)
ggsave("Fig_Qual_SpeechRate.pdf",p2, width=3, height=6)


# Error per syllable
d3_a = d3[which(d3$LeyoTextoA == "SI" & d3$CompletoTextoA == "SI"),]
d3_b = d3[which(d3$LeyoTextoB == "SI" & d3$CompletoTextoB == "SI"),]

d3_A = data.frame(Site = c(d3_a$Esitio), Prompt = rep(c("Prompt A"), each=length(d3_a$Esitio)), Score = c(d3_a$ScoreA), Error=c(d3_a$ErrorA))
d3_B = data.frame(Site = c(d3_b$Esitio), Prompt = rep(c("Prompt B"), each=length(d3_b$Esitio)), Score = c(d3_b$ScoreB), Error=c(d3_b$ErrorB))

df3_new = rbind(d3_A, d3_B)

df3_new$Site[which(df3_new$Site=="BS")] = "Coastal"
df3_new$Site[which(df3_new$Site=="SC")] = "Lowland"

df3_new$ErrorB10 = df3_new$Error*10

p3 = ggplot(df3_new, aes(x=ErrorB10, y=Score, color=Site, group=Site)) +
  geom_jitter() +  facet_wrap(vars(Prompt),nrow=2) + 
  scale_color_manual(values=c("Coastal" ="#3187cf", "Lowland" ="#cf7931")) + 
  theme(legend.position="bottom") + xlab("Error rate (errors per 10-syllables)") + ylab("Reading score (Likert scale)")

print(p3)
ggsave("Fig_Qual_ErrorRate.pdf",p3, width=3, height=6)


# Correlations between Prompts
d4 = df[which(df$LeyoTextoA == "SI" & df$CompletoTextoA == "SI" & df$LeyoTextoB == "SI" & df$CompletoTextoB == "SI" & df$RateA<7 & df$RateB<7),]

d4$Site = d4$Esitio
d4$Site[which(d4$Site=="BS")] = "Coastal"
d4$Site[which(d4$Site=="SC")] = "Lowland"
d4 = d4[which(d4$Site %in% c("Coastal", "Lowland")),]


# Quick regressions
reg_r = summary(lm(RateB ~ RateA, data=d4))
reg_e = summary(lm(ErrorB ~ ErrorA, data=d4))
reg_s = summary(lm(ScoreB ~ ScoreA, data=d4))

outcomes_1 = matrix(NA,nrow=3, ncol=5)

outcomes_1[1,] = make_res(reg_r, "Reading rate, B", "Reading rate, A")
outcomes_1[2,] = make_res(reg_e, "Error rate, B", "Error rate, A")
outcomes_1[3,] = make_res(reg_s, "Likert score, B", "Likert score, A")

xtable(outcomes_1)

# Regression for predicting scores 
d4$reading_rate_avg = rowMeans(d4[,which(colnames(d4) %in% c("RateA","RateB"))],na.rm=TRUE)
d4$error_rate_avg = rowMeans(d4[,which(colnames(d4) %in% c("ErrorA","ErrorB"))],na.rm=TRUE)
d4$score_avg = rowMeans(d4[,which(colnames(d4) %in% c("ScoreA", "ScoreB"))],na.rm=TRUE)

summary(lm(score_avg ~ reading_rate_avg + error_rate_avg, data=d4))

reg_rate_edu = summary(lm(reading_rate_avg ~ EducationYears, data=d4))
reg_errr_edu = summary(lm(error_rate_avg ~ EducationYears, data=d4))
reg_scor_edu = summary(lm(score_avg ~ EducationYears, data=d4))

reg_rate_age = summary(lm(reading_rate_avg ~ Age, data=d4))
reg_errr_age = summary(lm(error_rate_avg ~ Age, data=d4))
reg_scor_age = summary(lm(score_avg ~ Age, data=d4))

outcomes_2 = matrix(NA,nrow=6, ncol=5)

outcomes_2[1,] = make_res(reg_rate_edu, "Reading rate", "Education")
outcomes_2[2,] = make_res(reg_errr_edu, "Error rate", "Education")
outcomes_2[3,] = make_res(reg_scor_edu, "Likert score", "Education")

outcomes_2[4,] = make_res(reg_rate_age, "Reading rate", "Age")
outcomes_2[5,] = make_res(reg_errr_age, "Error rate", "Age")
outcomes_2[6,] = make_res(reg_scor_age, "Likert score", "Age")

         
############# Plotting education and scores
df4_new = data.frame(
 Outcome = c(d4$score_avg, d4$score_avg, d4$reading_rate_avg, d4$reading_rate_avg, d4$error_rate_avg, d4$error_rate_avg),
 Predictor = c(d4$EducationYears, d4$Age, d4$EducationYears, d4$Age, d4$EducationYears, d4$Age),
 Site = rep(d4$Site, 6),
 Metric=rep(c("Reading score (Likert scale)","Reading score (Likert scale)","Reading rate (syllables per second)","Reading rate (syllables per second)","Error rate (errors per 10-syllables)","Error rate (errors per 10-syllables)"),each=length(d4$score_avg)),
 Covariate=rep(c("Education (Years)","Age","Education (Years)","Age","Education (Years)","Age"),each=length(d4$score_avg))
 )

p4 = ggplot(df4_new, aes(x=Predictor, y=Outcome, color=Site, group=Site)) +
  geom_jitter(height=0.1) +  facet_grid(Metric~Covariate,scales="free") +
  scale_color_manual(values=c("Coastal" ="#3187cf", "Lowland" ="#cf7931")) + #geom_smooth(method = 'lm', formula = y ~ splines::bs(x, degree=7), aes(fill = after_scale(color)), alpha = 0.2) +
  theme(legend.position="bottom") + xlab(" ") + ylab(" ")


ggsave("Fig_AgeEdu_RateScore.pdf",p4, width=6, height=8)


summary(lm(reading_rate_avg ~ EducationYears, data=d4))




