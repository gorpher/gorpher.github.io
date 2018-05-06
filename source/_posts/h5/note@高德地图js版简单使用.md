---
title: 高德地图web js版使用
date: {{date}}
categories: note
tags: 
- js
- 高德地图
---
# 高德地图web版使用

```html
<script type="text/javascript" src="http://webapi.amap.com/maps?v=1.3&key=5774e5d7879ad6affd51e5f8dffde51d"></script>
```


Marker点标记、
Polyline折线、
Polygon多边形、
Circle圆等。
```js
var marker = new AMap.Marker({
    position: [116.480983, 39.989628],//marker所在的位置
    map:map//创建时直接赋予map属性
});
//也可以在创建完成后通过setMap方法执行地图对象
marker.setMap(map);
```

服务插件以及
工具插件，
比如工具条、
比例尺、
路线规划、
高级信息窗体等等
```js
AMap.plugin(['AMap.ToolBar','AMap.AdvancedInfoWindow'],function(){
    //创建并添加工具条控件
    var toolBar = new AMap.ToolBar();
    map.addControl(toolBar);
    //创建高级信息窗体并在指定位置打开
    var infowindow = new AMap.AdvancedInfoWindow({
      content: '<div class="info-title">高德地图</div><div class="info-content">'+
            '<img src="http://webapi.amap.com/images/amap.jpg">'+
            '高德是中国领先的数字地图内容、导航和位置服务解决方案提供商。<br>'+
            '<a target="_blank" href="http://mobile.amap.com/">点击下载高德地图</a></div>',
      offset: new AMap.Pixel(0, -30)
    });
    infowindow.open(map,[116.480983, 39.989628]);
})
```
类名 | 类功能说明 
-------- | ---
AMap.ToolBar| 工具条，控制地图的缩放、平移等
AMap.Scale|比例尺，显示当前地图中心的比例尺
AMap.OverView|鹰眼，显示缩略图
AMap.MapType|图层切换，用于几个常用图层切换显示
AMap.Geolocation|定位，提供了获取用户当前准确位置、所在城市的方法
AMap.AdvancedInfoWindow|高级信息窗体，整合了周边搜索、路线规划功能
AMap.Autocomplete|输入提示，提供了根据关键字获得提示信息的功能
AMap.PlaceSearch|地点搜索服务，提供了关键字搜索、周边搜索、范围内搜索等功能
AMap.PlaceSearchLayer|搜索结果图层类，将搜索结果作为图层展示
AMap.DistrictSearch|行政区查询服务，提供了根据名称关键字、citycode、adcode来查询行政区信息的功能
AMap.LineSearch|公交路线服务，提供公交路线相关信息查询服务
AMap.StationSearch|公交站点查询服务，提供途经公交线路、站点位置等信息
AMap.Driving|驾车路线规划服务，提供按照起、终点进行驾车路线的功能
AMap.Transfer|公交路线规划服务，提供按照起、终点进行公交路线的功能
AMap.Walking|步行路线规划服务，提供按照起、终点进行步行路线的功能
AMap.Riding|骑行路线规划服务，提供按照起、终点进行骑行路线的功能
AMap.DragRoute|拖拽导航插件，可拖拽起终点、途经点重新进行路线规划
AMap.ArrivalRange|公交到达圈，根据起点坐标，时长计算公交出行是否可达及可达范围
AMap.Geocoder|地理编码与逆地理编码服务，提供地址与坐标间的相互转换
AMap.CitySearch|城市获取服务，获取用户所在城市信息或根据给定IP参数查询城市信息
AMap.IndoorMap|室内地图，用于在地图中显示室内地图
AMap.MouseTool|鼠标工具插件
AMap.CircleEditor|圆编辑插件
AMap.PolyEditor|折线、多边形编辑插件
AMap.MarkerClusterer|点聚合插件
AMap.RangingTool|测距插件，可以用距离或面积测量
AMap.CloudDataLayer|云图图层，用于展示云图信息
AMap.CloudDataSearch|云图搜索服务，根据关键字搜索云图点信息
AMap.Weather|天气预报插件，用于获取未来的天气信息
AMap.RoadInfoSearch|道路信息查询，已停止数据更新，反馈信息仅供参考
AMap.Hotspot|热点插件，地图热点已默认开启，不用手动添加，由Map的isHotspot属性替代
AMap.Heatmap|热力图插件

# 地图基础控件
```js

    var map = new AMap.Map('container',{
    zoom: 10,
    center: [116.39,39.9]
    });
 
AMap.plugin(['AMap.ToolBar','AMap.Scale','AMap.OverView'],
    function(){
        map.addControl(new AMap.ToolBar());

        map.addControl(new AMap.Scale());

        map.addControl(new AMap.OverView({isOpen:true}));
});
```
名称|类名|简介
---|---|---
工具条|ToolBar|集成了缩放、平移、定位等功能按钮在内的组合控件
比例尺|Scale|展示地图在当前层级和纬度下的比例尺
定位|Geolocation|用来获取和展示用户主机所在的经纬度位置
鹰眼|OverView|在地图右下角显示地图的缩略图
类别切换|MapType|实现默认图层与卫星图、实施交通图层之间切换的控

# 定位

**AMap.Geolocation**  *定位插件，整合了浏览器定位、精确IP定位、sdk辅助定位多种手段*
**Map.CitySearch**   *城市查询，IP定位获取当前城市信息*
## AMap.Geolocation 插件

### 官网demo
```js
mapObj = new AMap.Map('iCenter');
mapObj.plugin('AMap.Geolocation', function () {
    geolocation = new AMap.Geolocation({
        enableHighAccuracy: true,//是否使用高精度定位，默认:true
        timeout: 10000,          //超过10秒后停止定位，默认：无穷大
        maximumAge: 0,           //定位结果缓存0毫秒，默认：0
        convert: true,           //自动偏移坐标，偏移后的坐标为高德坐标，默认：true
        showButton: true,        //显示定位按钮，默认：true
        buttonPosition: 'LB',    //定位按钮停靠位置，默认：'LB'，左下角
        buttonOffset: new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
        showMarker: true,        //定位成功后在定位到的位置显示点标记，默认：true
        showCircle: true,        //定位成功后用圆圈表示定位精度范围，默认：true
        panToLocation: true,     //定位成功后将定位到的位置作为地图中心点，默认：true
        zoomToAccuracy:true      //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
    });
    mapObj.addControl(geolocation);
    geolocation.getCurrentPosition();
    AMap.event.addListener(geolocation, 'complete', onComplete);//返回定位信息
    AMap.event.addListener(geolocation, 'error', onError);      //返回定位出错信息
});
```
### 自己demo
```js
mapObj = new AMap.Map('iCenter');
		mapObj.plugin('AMap.Geolocation', function () {
		    geolocation = new AMap.Geolocation({
		        enableHighAccuracy: true,//是否使用高精度定位，默认:true
		        timeout: 10000,          //超过10秒后停止定位，默认：无穷大
		        maximumAge: 0,           //定位结果缓存0毫秒，默认：0
		        convert: true,           //自动偏移坐标，偏移后的坐标为高德坐标，默认：true
		        showButton: true,        //显示定位按钮，默认：true
		        buttonPosition: 'LB',    //定位按钮停靠位置，默认：'LB'，左下角
		        buttonOffset: new AMap.Pixel(10, 20),//定位按钮与设置的停靠位置的偏移量，默认：Pixel(10, 20)
		        showMarker: true,        //定位成功后在定位到的位置显示点标记，默认：true
		        showCircle: true,        //定位成功后用圆圈表示定位精度范围，默认：true
		        panToLocation: true,     //定位成功后将定位到的位置作为地图中心点，默认：true
		        zoomToAccuracy:true      //定位成功后调整地图视野范围使定位位置及精度范围视野内可见，默认：false
		    });
		    mapObj.addControl(geolocation);
		    geolocation.getCurrentPosition();
		    AMap.event.addListener(geolocation, 'complete', onComplete);//返回定位信息
		    AMap.event.addListener(geolocation, 'error', onError);      //返回定位出错信息
		});
		function  onComplete(result){
			console.log(result.formattedAddress);  //定位成功获取地址信息
			console.log(result.position); //定位成功获取定位结果
            console.log(result.location_type); //定位结果的来源，可能的值有:'html5'、'ip'、'sdk'
		}
		function  onError(error){

			console.log(error.info);

			console.log(error.message);
			if('NOT_SUPPORTED'==error.info){
				console.log('当前浏览器不支持定位功能 ');
			}
			if('FAILED'==error.info){
				console.log('定位失败,失败原因可在message字段中获得。定位失败的原因');
		}
}
```
### GeolocationResult 对象

属性  类型  说明
position    LngLat  定位结果
accuracy    Number  精度范围，单位：米
location_type   String  定位结果的来源，可能的值有:'html5'、'ip'、'sdk'
message String  形成当前定位结果的一些信息
isConverted Boolean 是否经过坐标纠偏
info    String  状态信息 "SUCCESS"
addressComponent    AddressComponent    地址信息，详情参考Geocoder
formattedAddress    String  地址
pois    Array   定位点附近的POI信息，extensions等于'base'的时候为空
roads   Array   定位点附近的道路信息，extensions等于'base'的时候为空
crosses Array   定位点附近的道路交叉口信息，extensions等于'base'的时候为空

### Geolocation的方法
isSupported( ) Boolean  是否支持浏览器定位，当不支持是getCurrentPosition也会使用尝试进行精确IP定位
getCurrentPosition(callback:function(status,result){})      获取用户当前的精确位置信息
当回调函数中的status为complete的时候表示定位成功，result为GeolocationResult对象;
当回调函数中的status为error的时候表示定位失败，result为GeolocationError对象；                 callback的方式和事件监听的方式二者选择一种即可。
watchPosition( )    Number  使用浏览器定位接口监控当前位置，移动端有效。在监控过程中，每隔一段时间会自动调用定位成功或失败的回调函数。
注：由于时间间隔受浏览器限制，如您想自定义时间间隔，建议您使用定时器，每隔一段时间调用一次getCurrentPosition获取当前位置。
clearWatch(watchId:Number)  Number  取消对当前位置的监控
getCityInfo(callback:function(status,result){})     进行IP城市查询
status为complete的时候表示查询成功，result包含省、市、adcode、citycode、城市中心点center等信息；
status为error的时候表示查询失败

