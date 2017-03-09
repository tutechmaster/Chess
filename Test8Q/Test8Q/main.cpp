//
//  main.cpp
//  Test8Q
//
//  Created by Tuuu on 3/9/17.
//  Copyright © 2017 Tuuu. All rights reserved.
//

#include <iostream>
#include<stdio.h>
int dong[8], cot[8], cheodausac[15], cheodauhuyen[15];
int dem=0;
char banco[8][8];
void khoitaobanco(){
    for(int i=0;i<8;i++)
        for(int j=0;j<8;j++)
            banco[i][j]='+';
}

void khoitao(){
    int i;
    for(i=0;i<8;i++){
        cot[i]=1;
        dong[i]=-1;
    }
    for(i=0;i<15;i++){
        cheodausac[i]=1;
        cheodauhuyen[i]=1;
    }
}
void print();
void thu(int i){
    int j;
    khoitaobanco();
    for(j=0;j<8;j++)
    {
        if(cot[j]==1&&cheodausac[i+j]==1&&cheodauhuyen[i-j+7]==1)
        {
            dong[i]=j;
            cot[j]=0;
            cheodausac[i+j]=0;
            cheodauhuyen[i-j+7]=0;
            if(i<7)
            {
                thu(i+1);
            }
            //hien thi ket qua
            else
            {
                dem++;
                for(int i=0;i<8;i++){
                    banco[i][dong[i]]='Q';
                }
            }
            if(dem==1)
            {
                break;
            }
            //phuc hoi lai
            cot[j]=1;
            cheodausac[i+j]=1;
            cheodauhuyen[i-j+7]=1;
        }
    }
}
void timquanhau(){
    int i;
    khoitao();
    thu(0);
}


void hienthisaumoinuocdi(){
    
    
    printf("\t\tBAN CO\n\n");
    for(int i=0;i<8;i++){
        for(int j=0;j<8;j++){
            printf("%3c",banco[i][j]);
        }
        printf("\n\n");
    }
    printf("\t\tHIEN THI SAU MOI NUOC DI\n");
    for(int nuocdi=0;nuocdi<9;nuocdi++){
        printf("Nuoc %d\n",nuocdi);
        for(int i=0;i<8;i++){
            for(int j=0;j<8;j++){
                if(i>=nuocdi&&banco[i][j]=='Q'){
                    char ch='+';
                    printf("%3c",ch);
                }
                else
                    printf("%3c",banco[i][j]);
            }
            printf("\n\n");
        }
        
    }
}
int main(int argc, const char * argv[]) {
    // insert code here...
    timquanhau();
    hienthisaumoinuocdi();
    return 0;
}
