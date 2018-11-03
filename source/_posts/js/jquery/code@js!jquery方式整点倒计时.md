var daka = function(){
				var nowHours = Math.floor(new Date().getMinutes());
				var nextHours = 60-nowHours;
				var second =  Math.floor(new Date().getSeconds());
				var nextSecond = 60-second;
				setTimeout(function(){
					if(second==60){
						nextHours--;
						nextSecond--;
					}
					if(nextHours==0){
						console.log("该打卡了;");
					}
					second++;
					//console.log("距离下次打卡时间"+nextHours+":"+nextSecond);
					//console.log("这是自加的："+second+"----");	
					$(".lastTime").html(nextHours+"分"+nextSecond+"秒");
					daka();
				},1000);
}