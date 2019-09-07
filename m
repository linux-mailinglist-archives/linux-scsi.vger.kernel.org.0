Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 664F3AC944
	for <lists+linux-scsi@lfdr.de>; Sat,  7 Sep 2019 22:43:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406160AbfIGUng (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Sat, 7 Sep 2019 16:43:36 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:52988 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727251AbfIGUng (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Sat, 7 Sep 2019 16:43:36 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x87Kd4LG163901;
        Sat, 7 Sep 2019 20:43:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=FjfyYykhnGr9m5yu7nJC4bKVeUM/Qe4ndBCysAda6/A=;
 b=qW1P186OFebuIRdBF5/ogxBP5v7Eru18zkuk4wSEyZ/JKt/8HwMkJRBS1AqGQ9W6F1rr
 dY4waendBEYnySVabroRaQBCYTj5NlGU1kOCww+EMaC162kTwCO5SFkONw44lov+prj8
 FrNcu6VjEEyDlNovJY3G17CnTSR2etRFhPXHdjRM/AhrQA362SQ0cHTxbYVx0aTA+M5o
 YnmVoJCxV3NwW5vky+G1ZsuUYHPm7O6QISwdJZipfWOA+UcwouONFcYPjutCh5b7A1YX
 kj332yHGVGl+w5z4w+ulfNznjz0tgZvsY+Pog1R4ZPDv2C52gQ/1a1uyhxp15XlOTXxy 8A== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 2uvkpug09t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Sep 2019 20:43:16 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x87KhEnG098419;
        Sat, 7 Sep 2019 20:43:15 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 2uv4d0fhnt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 07 Sep 2019 20:43:15 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x87Kgkx1013952;
        Sat, 7 Sep 2019 20:42:47 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Sat, 07 Sep 2019 13:42:45 -0700
To:     YueHaibing <yuehaibing@huawei.com>
Cc:     <alim.akhtar@samsung.com>, <avri.altman@wdc.com>,
        <pedrom.sousa@synopsys.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <stanley.chu@mediatek.com>,
        <beanhuo@micron.com>, <arnd@arndb.de>,
        <linux-scsi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH -next] scsi: ufshcd: use devm_platform_ioremap_resource() to simplify code
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190904130348.24772-1-yuehaibing@huawei.com>
Date:   Sat, 07 Sep 2019 16:42:38 -0400
In-Reply-To: <20190904130348.24772-1-yuehaibing@huawei.com>
        (yuehaibing@huawei.com's message of "Wed, 4 Sep 2019 21:03:48 +0800")
Message-ID: <yq1zhjfj0sh.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9373 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=925
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1909070226
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9373 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1909070225
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


YueHaibing,

> Use devm_platform_ioremap_resource() to simplify the code a bit.
> This is detected by coccinelle.

Applied to 5.4/scsi-queue, thanks.

-- 
Martin K. Petersen	Oracle Linux Engineering
