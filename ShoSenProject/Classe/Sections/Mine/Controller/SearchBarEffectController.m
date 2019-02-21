//
//  SearchBarEffectController.m
//  微信搜索模糊效果
//
//  Created by MAC on 17/4/1.
//  Copyright © 2017年 MyanmaPlatform. All rights reserved.
//

#import "SearchBarEffectController.h"
#import "Masonry.h"
#import "UIView+Extension.h"

#define kWindow [UIApplication sharedApplication].keyWindow
#define kScreenW [UIScreen mainScreen].bounds.size.width
#define kScreenH [UIScreen mainScreen].bounds.size.height

@interface SearchBarEffectController ()<UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic , strong)UISearchBar * searchBar;
@property(nonatomic , strong)UITableView * tableView;
@property(nonatomic , strong)UIView * backView;
@property(nonatomic , strong)UIView * headView;
@property(nonatomic , strong)NSMutableArray * serverDataArr;


@end

@implementation SearchBarEffectController
static NSString * const searchCell= @"searchCell";

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor colorWithRed:240/255.0 green:240/255.0 blue:240/255.0 alpha:0.5];
        self.frame = CGRectMake(0, 0, kScreenW, kScreenH);
        [self setUpSearch];
    }
    return self;
}
- (NSMutableArray *)serverDataArr
{
    if (_serverDataArr == nil) {
        _serverDataArr = [NSMutableArray array];
    }
    return _serverDataArr;
}
- (UIView *)headView
{
    if (_headView == nil) {
        _headView = [[UIView alloc]init];
        _headView.frame = CGRectMake(0, 0, kScreenW, 20);
        _headView.backgroundColor = kColor(@"111113");
    }
    return _headView;
}

- (UISearchBar *)searchBar
{
    if (_searchBar == nil) {
        _searchBar = [[UISearchBar alloc]init];
        _searchBar.frame = CGRectMake(0, 20, kScreenW, 44);
         UIImage *searchBarBg = [UIImage imageWithColor:kColor(@"111113") size:CGSizeMake(kwidth, 44)];
        //设置背景图片
        [_searchBar setBackgroundImage:searchBarBg];
        //设置背景色
        [_searchBar setBackgroundColor:[UIColor clearColor]];
        //设置文本框背景
        [_searchBar setSearchFieldBackgroundImage:searchBarBg forState:UIControlStateNormal];
//        _searchBar.tintColor = [UIColor redColor];
 
        UITextField*searchField = [_searchBar valueForKey:@"_searchField"];//更改searchBar 中PlaceHolder 字体颜色
        searchField.textColor= [UIColor whiteColor];
        _searchBar.barTintColor = kColor(@"111113");



        
          [_searchBar setPlaceholder:@"请输入内容"];
        [_searchBar setDelegate:self];
        [_searchBar setKeyboardType:UIKeyboardTypeDefault];
//        [_searchBar setTranslucent:YES];//设置是否透明
        [_searchBar setSearchBarStyle:UISearchBarStyleProminent];
        [_searchBar setShowsCancelButton:YES];
        _searchBar.tintColor = [UIColor whiteColor];
        
    }
    return _searchBar;
}
- (UIView *)backView
{
    if (_backView == nil) {
        _backView = [[UIView alloc]init];
        _backView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }
    return  _backView;
}
- (UITableView *)tableView
{
    if (_tableView == nil) {
        _tableView = [[UITableView alloc]init];
        _tableView.tableFooterView = [[UIView alloc]init];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
    
}
- (void)setEffectArray:(NSArray *)effectArray
{
    _effectArray = effectArray;
    
}
- (void)setUpSearch
{
    NSLog(@"setUpSearch");
    [self addSubview:self.headView];
    [self addSubview:self.searchBar];
    [self addSubview:self.backView];
    
    [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(_searchBar.mas_bottom);
        make.left.mas_equalTo(0);
        make.width.mas_equalTo(kScreenW);
        make.height.mas_equalTo(kScreenH);
    }];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //    if ( tableView == self.tableView) {
    //        return self.effectArray.count;
    //    }
    NSLog(@"%lu",(unsigned long)self.serverDataArr.count);
    return self.serverDataArr.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:searchCell];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:searchCell];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@",_serverDataArr[indexPath.row][@"nickName"]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 46;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"1");
}

- (void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    
    [_backView addSubview:self.tableView];
    [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(0);
        make.left.right.mas_equalTo(0);
        make.bottom.mas_equalTo(_backView.mas_bottom);
    }];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    self.block(self.searchBar.text);
    [self hidden];
}

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    [self filterContentForSearchText:searchText scope:self.searchBar.scopeButtonTitles[1]];
}

#pragma mark - 源字符串内容是否包含或等于要搜索的字符串内容
- (void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    NSMutableArray *tempResults = [NSMutableArray array];
    NSUInteger searchOptions = NSCaseInsensitiveSearch | NSDiacriticInsensitiveSearch;
    
    for (int i = 0; i < self.effectArray.count; i++) {
        
        NSString * storeString = self.effectArray[i];
        NSRange storeRange = NSMakeRange(0, storeString.length);
        
        NSRange foundRange = [storeString rangeOfString:searchText options:searchOptions range:storeRange];
        
        if (foundRange.length) {
            
            NSDictionary *dic=@{@"nickName":storeString};
            [tempResults addObject:dic];
        }
    }
    [self.serverDataArr removeAllObjects];
    [self.serverDataArr addObjectsFromArray:tempResults];
    [self.tableView reloadData];
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{
    [self hidden];
    
}
- (void)hidden
{
    [self removeFromSuperview];
}
- (void)show
{
    [UIView transitionWithView:kWindow duration:0.5 options:UIViewAnimationOptionTransitionCrossDissolve animations:^{
        [kWindow addSubview:self];
    } completion:^(BOOL finished) {
        finished = NO;
    }];
    
}

@end
