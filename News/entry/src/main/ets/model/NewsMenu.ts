export class NewsMenu{
  text:string
  index:number
  url:string
  icon:string
  iconSelected:string

  constructor(text:string,index:number,url:string,icon:string,iconSelected:string) {
    this.text=text
    this.index=index
    this.url=url
    this.icon=icon
    this.iconSelected=iconSelected
  }
}