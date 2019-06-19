Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 40ACA4B043
	for <lists+linux-scsi@lfdr.de>; Wed, 19 Jun 2019 04:53:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728195AbfFSCxY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 18 Jun 2019 22:53:24 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:38610 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726446AbfFSCxY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 18 Jun 2019 22:53:24 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2nOs8172852;
        Wed, 19 Jun 2019 02:53:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=KlZT1H04lGIFwlI+HNDvY/JoI2FFxetAZL03UDVy1HU=;
 b=L7dLfTITyVC5/syXk9msT8Ob7srV8eOw6W8UqDITSlI0IDORW+OOwaBfDNpxbImJVzRF
 m73R8CQFNf+HibPqGJyadYg/KQ9N0sxY8G7x6w0pEGhhlNk85eysQ5gcH3liIvmPlOhg
 eKSYJwrAOOZ6IMZdZFxSSKElHQkxE9Kkd+sNnKmPtSfKHq2OJpyD0qYS2TW0V/ra2rxQ
 Ouw5ThB4tmIgDFV1W8brGvQ7gDwZ5JZkPdl8eQWoPvghgk9TdBBhfgiEUnhIq+PgUaLJ
 nD49cTR2pzwPCtOJZLzYeC85PrCerplV82gjxXi5lZB474kuerVa70uDsw/owDWAcHFk Lw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by aserp2120.oracle.com with ESMTP id 2t78098q9q-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 02:53:20 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5J2rDMx038931;
        Wed, 19 Jun 2019 02:53:20 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 2t77yn2vfj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 19 Jun 2019 02:53:19 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x5J2rF7u031013;
        Wed, 19 Jun 2019 02:53:18 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 19 Jun 2019 02:53:15 +0000
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH] qla2xxx: Fix hardlockup in abort command during driver remove.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190614143627.10768-1-hmadhani@marvell.com>
Date:   Tue, 18 Jun 2019 22:53:05 -0400
In-Reply-To: <20190614143627.10768-1-hmadhani@marvell.com> (Himanshu Madhani's
        message of "Fri, 14 Jun 2019 07:36:27 -0700")
Message-ID: <yq14l4mwajy.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=647
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906190021
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9292 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=691 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906190021
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Himanshu,

> From: Arun Easi <aeasi@marvell.com>
>
> [436194.555537] NMI watchdog: Watchdog detected hard LOCKUP on cpu 5
> [436194.555558] RIP: 0010:native_queued_spin_lock_slowpath+0x63/0x1e0
>
> [436194.555563] Call Trace:
> [436194.555564]  _raw_spin_lock_irqsave+0x30/0x40
> [436194.555564]  qla24xx_async_abort_command+0x29/0xd0 [qla2xxx]
> [436194.555565]  qla24xx_abort_command+0x208/0x2d0 [qla2xxx]
> [436194.555565]  __qla2x00_abort_all_cmds+0x16b/0x290 [qla2xxx]
> [436194.555565]  qla2x00_abort_all_cmds+0x42/0x60 [qla2xxx]
> [436194.555566]  qla2x00_abort_isp_cleanup+0x2bd/0x3a0 [qla2xxx]
> [436194.555566]  qla2x00_remove_one+0x1ad/0x360 [qla2xxx]
> [436194.555566]  pci_device_remove+0x3b/0xb0

Applied to 5.2/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
