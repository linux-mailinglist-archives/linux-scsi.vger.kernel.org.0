Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5083326251F
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 04:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgIICT6 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 22:19:58 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33720 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726708AbgIICTz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 22:19:55 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0892JE6B151330;
        Wed, 9 Sep 2020 02:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=eH2iHa+jCN0rFFGdRN8keS1i3vJsoBSgUzoLO5Z9pSg=;
 b=O0Z05hJvf5lMFx3XqSoW6RKVh1ev7W/kGmTC56dmYl+eP80ekY3mJ/t8iMbeXzoJPqMV
 bkyfF/HbYGvmmMTvgrTivt8EDoNiOnjJkNOUAFQnYdoUJ8j+8Ie6QFF0PGLPmk/WCX5X
 5bNihZdin/Bb/zAemXm3sp7t/7LuRGDMaa3XLZhIEWuVimq6YmgmIvE/xwdrziChkZp9
 Gh2yg8iuUkY7CjBZaUzX6AiGez9lyoqAYio9LEOArBu3L3ebQ5b4IqDRD4IdKvJq233g
 flPT77My+Dui3z9LO2dp2lxxvnVMu6zbWLcCz2eonerv4/ernqVY/prvZDyAndiMfw+K pA== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2130.oracle.com with ESMTP id 33c23qy11v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 02:19:40 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0892F1ip132023;
        Wed, 9 Sep 2020 02:17:39 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3020.oracle.com with ESMTP id 33cmk53ycp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 02:17:39 +0000
Received: from abhmp0016.oracle.com (abhmp0016.oracle.com [141.146.116.22])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0892HaXQ010872;
        Wed, 9 Sep 2020 02:17:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 19:17:36 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     rnayak@codeaurora.org, asutoshd@codeaurora.org,
        nguyenb@codeaurora.org, linux-scsi@vger.kernel.org,
        saravanak@google.com, kernel-team@android.com, salyzyn@google.com,
        hongwus@codeaurora.org, Can Guo <cang@codeaurora.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Bean Huo <beanhuo@micron.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>
Subject: Re: [PATCH v2] scsi: ufs: Remove an unpaired ufshcd_scsi_unblock_requests() in err_handler()
Date:   Tue,  8 Sep 2020 22:17:22 -0400
Message-Id: <159961781204.6233.3735126099362298555.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1597798958-24322-1-git-send-email-cang@codeaurora.org>
References: <1597798958-24322-1-git-send-email-cang@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=999 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090020
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 18 Aug 2020 18:02:29 -0700, Can Guo wrote:

> Commit 5586dd8ea250 ("scsi: ufs: Fix a race condition between error handler
> and runtime PM ops") moves the ufshcd_scsi_block_requests() inside
> err_handler(), but forgets to remove the ufshcd_scsi_unblock_requests() in
> the early return path. Correct the coding mistake.

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: ufs: Remove an unpaired ufshcd_scsi_unblock_requests() in err_handler()
      https://git.kernel.org/mkp/scsi/c/50807f22c89f

-- 
Martin K. Petersen	Oracle Linux Engineering
