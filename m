Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5203221327D
	for <lists+linux-scsi@lfdr.de>; Fri,  3 Jul 2020 06:03:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725968AbgGCEDK (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 3 Jul 2020 00:03:10 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33236 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725891AbgGCEDJ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 3 Jul 2020 00:03:09 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0633wMjv096713;
        Fri, 3 Jul 2020 04:03:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=io4O+nz9m5jtj+f2zllYgY89qZzs4U3HlfLOxp3iqns=;
 b=y1C/ebw9s45N2kgB5kEGr7fEfVtnlwkVmXbgnuh0eSsSDSKPVZYQdXSJzoWupo9QAsAF
 IwO3vha8KbbdhrFJeC8uBB0er6wFtbX2LDHHvflZWZkv2qxt/qRv6B1E9MpVWc5F2ftP
 9fYzo7wI9Zb7X6GFuFZfrCJoZ+Td7DgndoE374DLUKOXRvvGTwe5jdDV8d59du/eHT07
 ut/ogt/qC3EPIvhj7zfSFjc0B4SDF3iqT1+sIweM706hhQd/0fWlVgkoa8S7hMNYGQYG
 lSztEFzkNt2d9WMyqf8EYuNEblK7hkj+Ea7786Tzid9vkaPjSxrLgU9YGRkIJ0jOlC+s qQ== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by userp2120.oracle.com with ESMTP id 31wxrnkp2u-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 03 Jul 2020 04:03:07 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0633wpxc161594;
        Fri, 3 Jul 2020 04:03:06 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3020.oracle.com with ESMTP id 31xg1b5m02-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 03 Jul 2020 04:03:06 +0000
Received: from abhmp0019.oracle.com (abhmp0019.oracle.com [141.146.116.25])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0634348H001334;
        Fri, 3 Jul 2020 04:03:05 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jul 2020 04:03:04 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Johannes Thumshirn <johannes.thumshirn@wdc.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Sreekanth Reddy <sreekanth.reddy@broadcom.com>,
        linux-scsi@vger.kernel.org,
        Sathya Prakash <sathya.prakash@broadcom.com>,
        Suganath Prabu Subramani 
        <suganath-prabu.subramani@broadcom.com>
Subject: Re: [PATCH] scsi: mpt3sas: fix error returns in BRM_status_show
Date:   Fri,  3 Jul 2020 00:02:59 -0400
Message-Id: <159374890395.14616.1650672550404224641.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701131454.5255-1-johannes.thumshirn@wdc.com>
References: <20200701131454.5255-1-johannes.thumshirn@wdc.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0
 mlxlogscore=755 suspectscore=0 bulkscore=0 mlxscore=0 adultscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2007030027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9670 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=765
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2007030027
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Wed, 1 Jul 2020 22:14:54 +0900, Johannes Thumshirn wrote:

> BRM_status_show() has several error branches, but none of them record the
> error in the error return.]
> 
> Also while at it remove the manual mutex_unlock() of the pci_access_mutex
> in case of an ongoing pci error recovery or host removal and jump to the
> cleanup lable instead.
> 
> [...]

Applied to 5.8/scsi-fixes, thanks!

[1/1] scsi: mpt3sas: Fix error returns in BRM_status_show
      https://git.kernel.org/mkp/scsi/c/c7e4dd5d84fc

-- 
Martin K. Petersen	Oracle Linux Engineering
