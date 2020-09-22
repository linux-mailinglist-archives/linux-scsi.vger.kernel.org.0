Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D4FE3273990
	for <lists+linux-scsi@lfdr.de>; Tue, 22 Sep 2020 05:59:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727393AbgIVD7u (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Sep 2020 23:59:50 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:50058 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726982AbgIVD7t (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 21 Sep 2020 23:59:49 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M3nm0t077591;
        Tue, 22 Sep 2020 03:57:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=uOeI0mEZoGzoHJH2NFV/v6sDrEmLIbUfKfJoYdr+VO4=;
 b=WL3P0Vz8m0irk9trD3wjDVRM55ChvJg3BsMZxyFAkAQDqhLpKD8fnZCkNpamgJSXtSBj
 BMXQWd2+ifQFcMkGxkJ/YnsF4yP9eYeq1Au+wyNahPOIS47bMe6QYeKuX3soXMOnOPx1
 dwEJ0mpzIY8OEOqcklaaBgyisvQmAG9dj1S5oAjalAGkitpCPNeawRD7ogvHRKUvgw9x
 7HVN+THqIkfIl3NpsNm3uaVw/H42TdCLAC++Dh9hlYMv0QhZQIqhKfdY7PqsB95S9orZ
 RagCchkvzsMvzldgz62gM3lscXUY3TNGgPzoOuFjcVxh2h5/ycJX4qjlreDU8spXiAfx 3A== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33q5rg8t7v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Sep 2020 03:57:39 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08M3uKsW073498;
        Tue, 22 Sep 2020 03:57:39 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33nurs31bn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 22 Sep 2020 03:57:39 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08M3vbJm019282;
        Tue, 22 Sep 2020 03:57:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 20:57:36 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, yokota@netlab.is.tsukuba.ac.jp,
        Jason Yan <yanaijie@huawei.com>, gotom@debian.or.jp,
        jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Hulk Robot <hulkci@huawei.com>
Subject: Re: [PATCH] scsi: nsp32: remove unneeded semicolon
Date:   Mon, 21 Sep 2020 23:57:04 -0400
Message-Id: <160074695007.411.3281798407245420346.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200911091049.2938158-1-yanaijie@huawei.com>
References: <20200911091049.2938158-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=961 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 impostorscore=0
 clxscore=1015 suspectscore=0 phishscore=0 malwarescore=0
 priorityscore=1501 mlxlogscore=993 adultscore=0 bulkscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009220030
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 11 Sep 2020 17:10:49 +0800, Jason Yan wrote:

> This addresses the following coccinelle warning:
> 
> drivers/scsi/nsp32.c:1250:4-5: Unneeded semicolon
> drivers/scsi/nsp32.c:1842:2-3: Unneeded semicolon

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: nsp32: Remove unneeded semicolon
      https://git.kernel.org/mkp/scsi/c/94e476520e1e

-- 
Martin K. Petersen	Oracle Linux Engineering
