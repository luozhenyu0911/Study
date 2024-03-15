setwd('E:\\99_pipeline\\study\\12_Rplot')
library(ggplot2)
N<-20
df1 <- data.frame(x=sort(rnorm(N)),y=sort(rnorm(N)))
df2 <- data.frame(x=df1$x+0.1*rnorm(N),y=df1$y+0.1*rnorm(N))

# 所有图层共享数据源和美学映射参数
ggplot(df1,aes(x,y,colour=x+y))+
  geom_line(size=1)+
  geom_point(shape=16,size=5)+
  guides(color=guide_colorbar(title="Point\nLine"))

#各图层对象均使用独立的数据源与美学映射参数
ggplot()+
  geom_line(aes(x,y,colour=x+y),df1,size=1)+    
  geom_point(aes(x,y,fill=x+y),df2,color="black",
             shape=21, size=5)+
  scale_fill_distiller(name="Point",palette="YlOrRd")+
  scale_color_distiller(name="Line",palette="Blues")


library(ggplot2)
mydata<-data.frame(Cut=c("Fair","Good","Very Good","Premium","Ideal"),
                   Price=c(4300,3800,3950,4700,3500))
order<-sort(mydata$Price,index.return=TRUE,decreasing = TRUE)
mydata$Cut <- factor(mydata$Cut, levels = mydata$Cut[order$ix])
head(mydata)
ggplot(data=mydata,aes(Cut,Price))+
  geom_bar(stat = "identity", width = 0.8,colour="black",size=0.25,fill="#FC4E07",alpha=1)


library(ggplot2)
library(reshape2)
mydata<-read.csv("data/MultiColumn_Data.csv",check.names=FALSE)
order<-sort(mydata$ "1996",index.return=TRUE,decreasing = TRUE) #根据“1996” 排序
mydata$Catergory<- factor(mydata$Catergory, levels = mydata$Catergory[order$ix]) 
#根据“1996”的排序结果设定因子向量的水平顺序
mydata<-melt(mydata,id.vars='Catergory') 
head(mydata)
ggplot(data=mydata,aes(Catergory,value,fill=variable))+
  geom_bar(stat="identity", color="black", position=position_dodge(),width=0.7,size=0.25)



mydata<-read.csv("data/StackedColumn_Data.csv")
Order<-sort(colSums(mydata[,2:ncol(mydata)]),index.return=TRUE,decreasing = TRUE) 
#根据列求和结果对数据排序
mydata<-mydata[,c(1,Order$ix+1)] 
#根据列求和结果对表格排序
mydata$Clarity <- factor(mydata$Clarity, levels = mydata$Clarity[c(1:5)])
# 由于输入时就已经按顺序导入表格，所以只需要保持固有的排序即可
mydata<-melt(mydata,id.vars='Clarity')
head(mydata)
Clarity variable value
1      Fair      SI1   390
2      Good      SI1  1700
3 Very_Good      SI1  3300
4   Premium      SI1  3500
5     Ideal      SI1  4200
6      Fair      VS1   130
ggplot(data=mydata,aes(variable,value,fill=Clarity))+
  geom_bar(stat="identity",position="stack", color="black", width=0.7,size=0.25)




