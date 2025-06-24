# Make Table 1
print("Table 1 results:")

t1 = cbind(table(df$Esitio, df$LeyoTextoA),table(df$Esitio, df$LeyoTextoB))

print(t1)

# Why no reading?
t2 = table(df$PorQueNoLeyoTextoA)
t3 = table(df$PorQueNoLeyoTextoB)

print("Didnt read Prompt A because:")
print(t2)
print("Didnt read Prompt B because:")
print(t3)

# Completion after starting
 dorA = 1 - sum(df$LeyoTextoA == "SI" & df$CompletoTextoA == "NO",na.rm=TRUE)/ sum(df$LeyoTextoA == "SI",na.rm=TRUE)
 dorB = 1 - sum(df$LeyoTextoB == "SI" & df$CompletoTextoB == "NO",na.rm=TRUE)/ sum(df$LeyoTextoB == "SI",na.rm=TRUE)

print("Fraction that started Prompt A and finished:")
print(dorA)
print("Fraction that started Prompt B and finished:")
print(dorB)


# Qualitative scores
d2_A = data.frame(Site = c(df$Esitio), Prompt = rep(c("A"), each=length(df$Esitio)), Score = c(df$ScoreA))
d2_B = data.frame(Site = c(df$Esitio), Prompt = rep(c("B"), each=length(df$Esitio)), Score = c(df$ScoreB))

d2_A = d2_A[which(!is.na(d2_A$Score)),]
d2_B = d2_B[which(!is.na(d2_B$Score)),]

df2_A_new = ddply(d2_A, .(Site), summarise,
              prop=prop.table(table(Score)),
              Score=names(table(Score)))

df2_B_new = ddply(d2_B, .(Site), summarise,
              prop=prop.table(table(Score)),
              Score=names(table(Score)))

df2_A_new$Prompt = "Prompt A"
df2_B_new$Prompt = "Prompt B"

df2_new = rbind(df2_A_new, df2_B_new)

df2_new$Site[which(df2_new$Site=="BS")] = "Coastal"
df2_new$Site[which(df2_new$Site=="SC")] = "Lowland"

p1 = ggplot(df2_new, aes(Score, prop, fill=Site, group=Site)) + ylab("Proportion") + xlab("Reading score (Likert scale)") +
  geom_bar(stat="identity",position='dodge') + facet_wrap(vars(Prompt),nrow=2) + 
  scale_fill_manual(values=c("Coastal" ="#3187cf", "Lowland" ="#cf7931")) + 
  theme(legend.position="bottom") 

print(p1)
ggsave("Fig_Qual.pdf",p1, width=3, height=6)


