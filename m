Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F3312624D6
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 04:09:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728971AbgIICJp (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 22:09:45 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:39698 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728584AbgIICJm (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 22:09:42 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0891xwDW146301;
        Wed, 9 Sep 2020 02:09:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=0L0g7MYgkQjZSmJwJj+HxNbdDxlHF1I/OAVYlps3ngk=;
 b=PG0LQNC0nOv7YQ/CQ4GTJvAxpxdtbow1i9PwJKewqdo42jirEb7A75O4UbWzXUXUe1es
 598DFSSHlX14s4BcDEEQtyYL52bS55h6UPFsbU7BSGe/XqnWQ549hS+aT7/2MnHMYBC5
 TAbaRYPDysIUBblrS0WNtwoPoCP3z/MNMbX0UDLQWqIaVMhJ05kCCUoKdvBcSlAbpvQY
 +2l33a/dLbYpjuzlrQHYl+mRWrVLsKBYSoJ9tEXIh78JC3pvp+SWYX0GzopcskNFd+bu
 DnwdKux8KIPSCCiqIuKQgzXSsqfAOkT+U8bPB3ib756wWNReHDo/l3a5BRKDnm3cDJ7F ew== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 33c3amxtrb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 02:09:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08926Lkc185323;
        Wed, 9 Sep 2020 02:09:29 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33cmkwwfws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 02:09:29 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08929RGY008005;
        Wed, 9 Sep 2020 02:09:27 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 19:09:27 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Don Brace <don.brace@microsemi.com>, POSWALD@suse.com,
        mahesh.rajashekhara@microchip.com, Justin.Lindley@microchip.com,
        hch@infradead.org, joseph.szczypek@hpe.com,
        Kevin.Barnett@microchip.com, scott.benesh@microchip.com,
        gerry.morong@microchip.com, jejb@linux.vnet.ibm.com,
        scott.teel@microchip.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/2] smartpqi updates
Date:   Tue,  8 Sep 2020 22:09:09 -0400
Message-Id: <159961731707.5787.4901851684788264554.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <159864889781.13630.2796712754333982084.stgit@brunhilda>
References: <159864889781.13630.2796712754333982084.stgit@brunhilda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=999 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 priorityscore=1501
 clxscore=1011 bulkscore=0 malwarescore=0 lowpriorityscore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 mlxscore=0 impostorscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090017
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 28 Aug 2020 16:09:09 -0500, Don Brace wrote:

> These patches are based on Linus's tree
> 
> This small set of changes consist of:
>  * Changing e-mail address to Microchip
>  * Changing storagedev from esc.storagedev@microsemi.com
>    to storagedev@microchip.com

Applied to 5.10/scsi-queue, thanks!

[1/2] scsi: smartpqi: Update documentation
      https://git.kernel.org/mkp/scsi/c/5f59128c83fc
[2/2] scsi: smartpqi: Update copyright
      https://git.kernel.org/mkp/scsi/c/2a71268160b4

-- 
Martin K. Petersen	Oracle Linux Engineering
