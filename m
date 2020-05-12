Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F25671CEB6B
	for <lists+linux-scsi@lfdr.de>; Tue, 12 May 2020 05:29:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728816AbgELD3R (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 11 May 2020 23:29:17 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41092 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728709AbgELD3Q (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 11 May 2020 23:29:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C3OqVR133387;
        Tue, 12 May 2020 03:29:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=mime-version :
 message-id : date : from : to : cc : subject : references : in-reply-to :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=0li2tf0cDZmOobTmeOUk+m5pYKBF0QTai+cIH1bMS3Y=;
 b=XdU6rRriIaL0ZlTh9QFnNZwh0syqPSWRiRqz1gFPjo4Y8kCGph9lc/+Yag9gTFNwS/JN
 qeDT67djOza/+kbLacJmFtLfwmaOFTDFhNoarhhBpYIzb0HK1ojbGwtbtaHlIcfTuT9k
 O72P1WWgJAU0XlPnnNuPD1u3H3dK8xFEwhXXZAg64Ix0Ubzf2nWUJ3zUmczbDRwgOwHh
 w+mt1IlH8gNyH/Iw/T3TpQAZIyTtYmbed6JN8Ay2diXf8JAnlSjnHIFP4cmEW9++we/+
 XY5r+C+vn2cmKEEIKETDs3cJ6bwV7rJ9Rn9GPXqtfrAwIjPTL4uXP3SroGbGHWgH83cw 3Q== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30x3gsggpv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 12 May 2020 03:29:11 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 04C3NwB1044288;
        Tue, 12 May 2020 03:29:11 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 30ydspj6x5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 12 May 2020 03:29:11 +0000
Received: from abhmp0022.oracle.com (abhmp0022.oracle.com [141.146.116.28])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 04C3T9LE029091;
        Tue, 12 May 2020 03:29:09 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201) by default (Oracle
 Beehive Gateway v4.0) with ESMTP ; Mon, 11 May 2020 20:28:44 -0700
MIME-Version: 1.0
Message-ID: <158925392373.17325.7271834544265076683.b4-ty@oracle.com>
Date:   Tue, 12 May 2020 03:28:31 +0000 (UTC)
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH] scsi: ufs: Replace zero-length array with flexible-array
References: <20200507192550.GA16683@embeddedor>
In-Reply-To: <20200507192550.GA16683@embeddedor>
X-Mailer: git-send-email 2.26.2
Content-Type: text/plain; charset=ascii
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 mlxscore=0
 adultscore=0 mlxlogscore=612 malwarescore=0 bulkscore=0 spamscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2005120029
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9618 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 mlxlogscore=654
 malwarescore=0 adultscore=0 mlxscore=0 priorityscore=1501
 lowpriorityscore=0 impostorscore=0 clxscore=1015 bulkscore=0 phishscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2005120029
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 7 May 2020 14:25:50 -0500, Gustavo A. R. Silva wrote:

> The current codebase makes use of the zero-length array language
> extension to the C90 standard, but the preferred mechanism to declare
> variable-length types such as these ones is a flexible array member[1][2],
> introduced in C99:
> 
> struct foo {
>         int stuff;
>         struct boo array[];
> };
> 
> [...]

Applied to 5.8/scsi-queue, thanks!

[1/1] scsi: ufs: Replace zero-length array with flexible-array
      https://git.kernel.org/mkp/scsi/c/ec38c0adc0a1

-- 
Martin K. Petersen	Oracle Linux Engineering
