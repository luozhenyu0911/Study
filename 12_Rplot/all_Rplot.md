## 柱状图
### 绘制单数据系列柱形图
```r
library(ggplot2)
mydata<-data.frame(Cut=c("Fair","Good","Very Good","Premium","Ideal"),
                   Price=c(4300,3800,3950,4700,3500))
order<-sort(mydata$Price,index.return=TRUE,decreasing = TRUE)
mydata$Cut <- factor(mydata$Cut, levels = mydata$Cut[order$ix])
head(mydata)
          Catergory variable value
1 Temporary\nStream     1996  7.67
2 Permanent\nStream     1996  4.02
3              Lake     1996  3.95
4 Temporary\nStream     1997  5.84
5 Permanent\nStream     1997  6.45
6              Lake     1997  6.76
ggplot(data=mydata,aes(Cut,Price))+
  geom_bar(stat = "identity", width = 0.8,colour="black",size=0.25,fill="#FC4E07",alpha=1)
```
![Alt text](image.png)

### 绘制多数据系列柱形图
```R
library(ggplot2)
library(reshape2)
mydata<-read.csv("data/MultiColumn_Data.csv",check.names=FALSE)
order<-sort(mydata$ "1996",index.return=TRUE,decreasing = TRUE) #根据“1996” 排序
mydata$Catergory<- factor(mydata$Catergory, levels = mydata$Catergory[order$ix]) 
#根据“1996”的排序结果设定因子向量的水平顺序
mydata<-melt(mydata,id.vars='Catergory') 
> head(mydata)
          Catergory variable value
1 Temporary\nStream     1996  7.67
2 Permanent\nStream     1996  4.02
3              Lake     1996  3.95
4 Temporary\nStream     1997  5.84
5 Permanent\nStream     1997  6.45
6              Lake     1997  6.76
ggplot(data=mydata,aes(Catergory,value,fill=variable))+
  geom_bar(stat="identity", color="black", position=position_dodge(),width=0.7,size=0.25)
```
![Alt text](image-1.png)

### 绘制堆积柱形图

```r
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
```
![Alt text](image-2.png)

### 绘制百分比堆积柱形图























