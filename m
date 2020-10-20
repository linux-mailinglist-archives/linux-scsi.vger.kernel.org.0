Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 057DC285747
	for <lists+linux-scsi@lfdr.de>; Wed,  7 Oct 2020 05:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727421AbgJGDsp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 6 Oct 2020 23:48:45 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:36346 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727230AbgJGDs2 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 6 Oct 2020 23:48:28 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0973j5Uc045449;
        Wed, 7 Oct 2020 03:48:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=GevU+XZ1nZrKpSOPr3KRlYadt9iRjjcKnCaYjTdOTKg=;
 b=WMdKZustBg70aMzYXbWXYRpnBf9tKWtTYioZqR7MqkbsrijGYApje3hDEYVJrY/wc6KN
 D5tZTj7QAIavS/72UIGTNOQoFx8n8sXMFaAjAwo1vkJwOuKQ0uNQwQCI5OtfFfdlbMmf
 JfByE2H34edgMVvTOFyTwgpWkqfNUiZpMP5vX2Wvh5gL+W57ingmkUAfM5A2sv+4bouI
 kb6AGvEGTWv4USHUcqHXywX0uWXm0OHaBJ2/ArdQSaciScsM9W43cGit3WjPSwLIL1UT
 pNR49XvEFU6Wy/Yjtxaa5A+WOniySjsnuHLc6oaJQEYh3p9s7Epx7FJZ7VR1qFC9fatd sw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 33ym34mjy3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 07 Oct 2020 03:48:19 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0973jI3Q054837;
        Wed, 7 Oct 2020 03:48:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 33y2vnxxqm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 07 Oct 2020 03:48:18 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0973mHaY012518;
        Wed, 7 Oct 2020 03:48:17 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 06 Oct 2020 20:48:17 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Sesidhar Baddela <sebaddel@cisco.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Karan Tilak Kumar <kartilak@cisco.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [PATCH -next] scsi: snic: convert to use DEFINE_SEQ_ATTRIBUTE macro
Date:   Tue,  6 Oct 2020 23:47:56 -0400
Message-Id: <160204240581.16940.461252644570254951.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200916025030.3992991-1-liushixin2@huawei.com>
References: <20200916025030.3992991-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 mlxlogscore=999
 malwarescore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2010070023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9766 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 impostorscore=0 priorityscore=1501
 mlxscore=0 mlxlogscore=999 clxscore=1015 bulkscore=0 spamscore=0
 malwarescore=0 phishscore=0 suspectscore=0 adultscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010070023
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 16 Sep 2020 10:50:30 +0800, Liu Shixin wrote:

> Use DEFINE_SEQ_ATTRIBUTE macro to simplify the code.

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: snic: Convert to use DEFINE_SEQ_ATTRIBUTE macro
      https://git.kernel.org/mkp/scsi/c/936dc95d09d8

-- 
Martin K. Petersen	Oracle Linux Engineering
