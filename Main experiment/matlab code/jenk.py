# -*- coding: utf-8 -*-
"""
Created on Fri Jan 15 09:38:53 2021

@author: Administrator
"""

import jenkspy
import random
import xlrd
import xlsxwriter

#Bayesian network of surface temperature, the variables of interest are surface temperature, solar radiation, ocean temperature, water vapor, cloudiness
workbook = xlrd.open_workbook(r'D:/natural_onedim_q.xlsx')
sheet=workbook.sheets()[0]
asurf_onedim =sheet.col_values(0)
sw_r_onedim=sheet.col_values(1)
aosurf_onedim=sheet.col_values(2)
water_vapor_onedim=sheet.col_values(3)
Cloud_onedim=sheet.col_values(4)

#list_of_values = [random.random()*5000 for _ in range(12000)]
breaks_asurf = jenkspy.jenks_breaks(asurf_onedim, nb_class=7)
breaks_sw_r = jenkspy.jenks_breaks(sw_r_onedim, nb_class=7)
breaks_aosurf = jenkspy.jenks_breaks(aosurf_onedim, nb_class=7)
breaks_water_vapor = jenkspy.jenks_breaks(water_vapor_onedim, nb_class=7)
breaks_Cloud = jenkspy.jenks_breaks(Cloud_onedim, nb_class=7)
#print(breaks)



#Exporting data to a table
workbook = xlsxwriter.Workbook(r'D:/Natural_breakpoint_q_7class.xlsx')
worksheet = workbook.add_worksheet('Sheet1')
for i in range(len(breaks_asurf)):
    worksheet.write(i,0,breaks_asurf[i])
    worksheet.write(i,1,breaks_sw_r[i])
    worksheet.write(i,2,breaks_aosurf[i])
    worksheet.write(i,3,breaks_water_vapor[i])
    worksheet.write(i,4,breaks_Cloud[i])

workbook.close()