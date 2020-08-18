Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C3731247C82
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Aug 2020 05:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726696AbgHRDMy (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Aug 2020 23:12:54 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34090 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726620AbgHRDMr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Aug 2020 23:12:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07I375Li113766;
        Tue, 18 Aug 2020 03:12:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=T4KnJ90nFr3X+R54jxbSGKNyeNRn2/9AY0KJzLt469A=;
 b=TPz1q33X44cq1YOh3706oCLuCdZhein6zs0lTpYooHZ26bqhdI3Yx0IUW9j5BF00txWg
 zOPU7ajFA0vwqzhr9j/OO9AbK/9WdAwoKY4Y6WgaXIvq3d6ND82wsyVCy6SXUodq2f3J
 kUPYaF/ZUR2h1d/hiZDAIh+YMJtzuAQ6OPUq3XaYR6KwSQOsiCshC8wNsNybKa8Vg6Vs
 1ZFnPsYuVOC0T69WBmihESFM5n9V0PjWA/uUmcbHqGweMjcAuDahSVU/wE/wjC9KroGu
 9IdoJaR6kSSVVcYyQY3BDQAGS6EV1LM7WsLEeY5JnoHJ2xQUyMO4lhCIDt8mIoZ8mZrl 9Q== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 32x8bn22qp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 03:12:41 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07I386qv131261;
        Tue, 18 Aug 2020 03:12:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 32xs9mf4cd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 03:12:40 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 07I3Cd3Y029803;
        Tue, 18 Aug 2020 03:12:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Aug 2020 20:12:38 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Enzo Matsumiya <ematsumiya@suse.de>, linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        GR-QLogic-Storage-Upstream@marvell.com,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Nilesh Javali <njavali@marvell.com>
Subject: Re: [PATCH] scsi: qla2xxx: use MBX_TOV_SECONDS for mailbox command timeout values
Date:   Mon, 17 Aug 2020 23:12:25 -0400
Message-Id: <159772029326.19587.15399521049936315752.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200805200546.22497-1-ematsumiya@suse.de>
References: <20200805200546.22497-1-ematsumiya@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 adultscore=0 spamscore=0
 mlxscore=0 mlxlogscore=999 suspectscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180022
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 lowpriorityscore=0
 impostorscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 bulkscore=0 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2008180022
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 5 Aug 2020 17:05:46 -0300, Enzo Matsumiya wrote:

> Improves readability of qla_mbx.c

Applied to 5.9/scsi-fixes, thanks!

[1/1] scsi: qla2xxx: Use MBX_TOV_SECONDS for mailbox command timeout values
      https://git.kernel.org/mkp/scsi/c/c314a014b180

-- 
Martin K. Petersen	Oracle Linux Engineering
