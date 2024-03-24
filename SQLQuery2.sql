



--alter function Fn_TCNo(@number bigint)
--returns varchar(50)
--as
--begin
--declare @result varchar(50) ,@numbercheck nvarchar(11),
--@1st int , @2nd int, @3rd int ,@4th int ,@5th int , @6th int ,
--@7th int ,@8th int ,@9th int ,@10th int,@11th int ,
--@allSumCheck int,@10thRuleCheck1 int,@10thRuleCheck2 int,@11thRuleCheck int,
--@sumPlural int ,@sumSingular int
--set @numbercheck = Cast(@number as nvarchar(11))

--	if len(@number) != 11 --length check
--	begin
--	set @result ='false'
--	return @result
--	end

--set @1st =Cast(SUBSTRING(@numbercheck,1,1) as int)
--set @2nd =Cast(SUBSTRING(@numbercheck,2,1) as int)
--set @3rd =Cast(SUBSTRING(@numbercheck,3,1) as int)
--set @4th =Cast(SUBSTRING(@numbercheck,4,1) as int)
--set @5th =Cast(SUBSTRING(@numbercheck,5,1) as int)
--set @6th =Cast(SUBSTRING(@numbercheck,6,1) as int)
--set @7th =Cast(SUBSTRING(@numbercheck,7,1) as int)
--set @8th =Cast(SUBSTRING(@numbercheck,8,1) as int)
--set @9th =Cast(SUBSTRING(@numbercheck,9,1) as int)
--set @10th =Cast(SUBSTRING(@numbercheck,10,1) as int)
--set @11th =Cast(SUBSTRING(@numbercheck,11,1) as int)
----Ýlk 10 rakamýn toplamýnýn birler basamaðý, 11. rakamý vermelidir.
--set @allSumCheck = (@1st+@2nd+@3rd+@4th+@5th+@6th+@7th+@8th+@9th+@10th)%10
--		if(@11th != @allSumCheck)
--		begin
--		set @result ='false'
--		return @result
--		end
----1, 3, 5, 7 ve 9. rakamýn toplamýnýn 7 katý ile 2, 4, 6 ve 8. rakamýn toplamýnýn 9 katýnýn
----toplamýnýn birler basamaðý 10. rakamý vermektedir.	

--set @sumSingular = @1st+@3rd+@5th+@7th+@9th
--set @sumPlural = @2nd+@4th+@6th+@8th
--set @10thRuleCheck1 =((7*@sumSingular)+(9*@sumPlural))%10
--	if(@10th != @10thRuleCheck1)
--		begin
--		set @result ='false'
--		return @result
--		end
----1, 3, 5, 7 ve 9. rakamýn toplamýnýn 7 katýndan 2, 4, 6 ve 8. rakamýn toplamýný çýkarýn. Elde
----edilen sonucun birler basamaðý 10. rakamý verir.
--set @10thRuleCheck2 =(7*@sumSingular -@sumPlural)%10
--	if(@10th != @10thRuleCheck2)
--		begin
--		set @result ='false'
--		return @result
--		end
----1, 3, 5, 7 ve 9. rakamýn toplamýnýn 8 katýnýn birler basamaðý 11. rakamý vermektedir.
--set @11thRuleCheck =(8*@sumSingular)%10
--	if(@11th != @11thRuleCheck)
--		begin
--		set @result ='false'
--		return @result
--		end
--set @result = 'true'
--return @result
--end
--go
--select dbo.Fn_TCNo(36373669148)

alter function Fn_SplitMoney(@cash decimal(18,2))
returns 
@outputTable table
(
	Para nvarchar(10),
	Adet int
)
as
begin
declare @200count int ,@100count int ,@50count int,
@20count int,@10count int,@5count int,@1count int,
@50cent int ,@25cent int ,@10cent int , @5cent int ,@1cent int

set @200count = cast(@cash as int) / 200 -- 200 lira sayýsý
set @cash = @cash - 200 * @200count

set @100count = cast(@cash as int) / 100 -- 100 lira sayýsý
set @cash = @cash - 100 * @100count

set @50count = cast(@cash as int) / 50 -- 50 lira sayýsý
set @cash = @cash - 50 * @50count

set @20count = cast(@cash as int)/ 20 -- 20 lira sayýsý
set @cash = @cash - 20 * @20count

set @10count = cast(@cash as int) / 10 -- 10 lira sayýsý
set @cash = @cash - 10 * @10count

set @5count = cast(@cash as int) / 5 -- 5 lira sayýsý
set @cash = @cash - 5 * @5count

set @1count = cast(@cash as int) / 1 -- 1 lira sayýsý
set @cash = @cash - @1count

set @cash = @cash * 100 --kuruþ kontrolü

set @50cent = @cash / 50 --50 kuruþ sayýsý
set @cash = @cash - 50 *@50cent

set @25cent = @cash / 25 --25 kuruþ sayýsý
set @cash = @cash - 25 * @25cent

set @10cent = @cash / 10 --10 kuruþ sayýsý
set @cash = @cash - 10 * @10cent

set @5cent = @cash / 5 --5 kuruþ sayýsý
set @cash = @cash - 5 * @5cent

set @1cent = convert(int,@cash) --1 kuruþ sayýsý

insert into @outputTable values ('200',@200count)
insert into @outputTable values ('100',@100count)
insert into @outputTable values ('50',@50count)
insert into @outputTable values ('20',@20count)
insert into @outputTable values ('10',@10count)
insert into @outputTable values ('5',@5count)
insert into @outputTable values ('1',@1count)
insert into @outputTable values ('0,5',@50cent)
insert into @outputTable values ('0,25',@25cent)
insert into @outputTable values ('0,10',@10cent)
insert into @outputTable values ('0,5',@5cent)
insert into @outputTable values ('0,1',@1cent)
return
end
go
select * from  dbo.Fn_SplitMoney(5573.33)

