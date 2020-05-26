Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 936931BAF3D
	for <lists+linux-scsi@lfdr.de>; Mon, 27 Apr 2020 22:21:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726905AbgD0UVg (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 27 Apr 2020 16:21:36 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:56786 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726654AbgD0UVf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 27 Apr 2020 16:21:35 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03RKIvRQ007709;
        Mon, 27 Apr 2020 20:21:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=H14jPY9l1j2xxxqPK9+sMxTRCWagVVKludjxZMM69bI=;
 b=qU56nduMucvoKGGpi8DV90kSrJRZRwW6qPKaeuU58KFbNjkiXgGX4kkGPzIuMg0aVqUH
 6GyWysU4ALheWoUy68QwC/paD458XaUlgJ4iece9VPkZoHJDp5Tj04pWsor6VRsvDECe
 I+xqS/RB14s3hmy/xirpOMBC789wujhjxD7kqpnTZen72QaoYLmnzB/g9mVzMrA9R6i8
 bGwNclu0mMI5pfbq5Qj30cTEGd6oaRyHJnDrMrQnc3jgR6LHPW49BCqiI7DXs+WvJsYc
 TyBopYYxvyOpnfx4ChQuGX+GWeX9UQ4kK8faJmV9DI0TQ3smdx7bsNSlhnuSS6f78Egt NA== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 30nucfuw00-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 20:21:28 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03RKBxgn078378;
        Mon, 27 Apr 2020 20:21:28 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 30mxrr0666-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 27 Apr 2020 20:21:28 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 03RKLRWA029811;
        Mon, 27 Apr 2020 20:21:27 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 27 Apr 2020 13:21:27 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     skashyap@marvell.com, linux-kernel@vger.kernel.org,
        jejb@linux.ibm.com, QLogic-Storage-Upstream@qlogic.com,
        jhasan@marvell.com, linux-scsi@vger.kernel.org,
        Jason Yan <yanaijie@huawei.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: bnx2fc: remove unneeded semicolon in bnx2fc_fcoe.c
Date:   Mon, 27 Apr 2020 16:21:16 -0400
Message-Id: <158777063305.4076.1053092723665230286.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200421034019.27949-1-yanaijie@huawei.com>
References: <20200421034019.27949-1-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 mlxlogscore=856 malwarescore=0 bulkscore=0 spamscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004270164
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9604 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1015 priorityscore=1501
 mlxlogscore=926 impostorscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 mlxscore=0 spamscore=0 adultscore=0 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004270164
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 21 Apr 2020 11:40:19 +0800, Jason Yan wrote:

> Fix the following coccicheck warning:
> 
> drivers/scsi/bnx2fc/bnx2fc_fcoe.c:948:4-5: Unneeded semicolon
> drivers/scsi/bnx2fc/bnx2fc_fcoe.c:968:4-5: Unneeded semicolon

Applied to 5.8/scsi-queue, thanks!

[1/1] scsi: bnx2fc: Remove unneeded semicolon in bnx2fc_fcoe.c
      https://git.kernel.org/mkp/scsi/c/acfcb728bd57

-- 
Martin K. Petersen	Oracle Linux Engineering
