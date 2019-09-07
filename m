Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73364AC93F
	for <lists+linux-scsi@lfdr.de>; Sat,  7 Sep 2019 22:40:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405119AbfIGUkb (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 7 Sep 2019 16:40:31 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52370 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727307AbfIGUkb (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 7 Sep 2019 16:40:31 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x87Kd5wq111270;
        Sat, 7 Sep 2019 20:40:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=olvhehjxhdJO3R8+a/tqq0z8BONXBW8GY6wTkeV7v8M=;
 b=nQgEi5IKNFXNv2lE/HCGzt3C+f8dxjfD6FHQWpXwVyMkMVft5lNdbaejPP2fHbM81z3l
 uVGtaOyQTSWwlAnhBmaIik1WzdLPgnnC+7v5FaewsUdzHy8tx2Adywaedi2+uWyA7uMn
 4utTxcr2B97MuUfPttxed0jDx9zA7d22uLCZ4lguieZN28+XC9TftK2jZsev3/UbuQxE
 YlpncCqf0WGuuhEfgj/1W0uSuXQRUCL51bzj/Q7R/Ah8NxOItWZANsdo2l1LhSWa2x2O
 FkLBgmMAX2khHSCRdN87zWpz50NKkjjKJ+68c0JHeCtsVVEq1UEmMJMK797m6S+MO9YR ZQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 2uvkpfr08v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Sep 2019 20:40:17 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x87Kd1f6093459;
        Sat, 7 Sep 2019 20:40:16 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2uve9b7v2d-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Sep 2019 20:40:16 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x87KeDkK012427;
        Sat, 7 Sep 2019 20:40:13 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 07 Sep 2019 13:40:13 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Subhash Jadavani <subhashj@codeaurora.org>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: ufs: Use kmemdup in ufshcd_read_string_desc()
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190831124424.18642-1-yuehaibing@huawei.com>
Date:   Sat, 07 Sep 2019 16:40:10 -0400
In-Reply-To: <20190831124424.18642-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Sat, 31 Aug 2019 12:44:24 +0000")
Message-ID: <yq18sqzkfh1.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9373 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=744
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909070225
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9373 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=828 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909070225
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


YueHaibing,

> Use kmemdup rather than duplicating its implementation

Applied to 5.4/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
