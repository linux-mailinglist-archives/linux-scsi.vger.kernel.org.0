Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A58EA2624D5
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 04:09:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728970AbgIICJn (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 22:09:43 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41576 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgIICJl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 22:09:41 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08921MFx087516;
        Wed, 9 Sep 2020 02:09:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=WnbcLsyAYf4dEBCk3sZDYjPxMuOLGge9Zdda9gpvKwo=;
 b=awGsvw48XIeuaypkqpiis+i9ORU65pbGSaxCWi1t9mJtDq1t9LGVOuAoOlpuTUqtp9b4
 UNXia3khhjdh3LvX1D0l2VUiaqaH9fFwFBwUO69nbyNOSAmMrsIbU+N42W0ZUDDWKoX8
 lTEEssi5UuREI7sRF69+73dqNlS60S53saHG4KzbtkiZNiotwLhTfBQCBmIEfuweEJLO
 2ULTs4W9M4pBIACU5LYCBrvxjfDg8sLhelETDb72pEwvil71pdXI4Dv8PQM/EoGHPz0x
 Og0R/yFtYNYW0vu8iPk3+aM3ZY5wOOadRgpbwx5N53KPt7wK037k2RRt6eyme9Xa4Eua fw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mkxvmr-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 02:09:39 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08925286095328;
        Wed, 9 Sep 2020 02:09:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33cmk53eup-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 02:09:39 +0000
Received: from abhmp0002.oracle.com (abhmp0002.oracle.com [141.146.116.8])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08929bpr008050;
        Wed, 9 Sep 2020 02:09:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 19:09:37 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Nilesh Javali <njavali@marvell.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com, linux-scsi@vger.kernel.org
Subject: Re: [PATCH] MAINTAINERS: update Marvell owned driver maintainers
Date:   Tue,  8 Sep 2020 22:09:16 -0400
Message-Id: <159961731708.5787.14902422587854673426.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200902073430.11787-1-njavali@marvell.com>
References: <20200902073430.11787-1-njavali@marvell.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=921 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=953
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090017
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 2 Sep 2020 00:34:30 -0700, Nilesh Javali wrote:

> Update Marvell owned driver maintainers and
> add Marvell Upstream email alias to the maintainers list.

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: MAINTAINERS: Update Marvell owned driver maintainers
      https://git.kernel.org/mkp/scsi/c/5d929371b71b

-- 
Martin K. Petersen	Oracle Linux Engineering
