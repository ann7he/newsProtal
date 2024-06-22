export class NewsType {
  newsTypeID: number
  typeName: string
  description: string //新闻类型


  constructor(newsTypeID: number,typeName: string, description: string) {
    this.newsTypeID = newsTypeID
    this.typeName = typeName
    this.description = description
  }
}

