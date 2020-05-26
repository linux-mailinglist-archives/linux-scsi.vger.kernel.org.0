Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 195691B35F0
	for <lists+linux-scsi@lfdr.de>; Wed, 22 Apr 2020 06:09:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725984AbgDVEJE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 22 Apr 2020 00:09:04 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:60900 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725810AbgDVEJE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 22 Apr 2020 00:09:04 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03M48RdH093049;
        Wed, 22 Apr 2020 04:08:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2020-01-29;
 bh=01vLL2jYGublTFwRnmBzxo+s/SGncI6ZQf2jugxAYto=;
 b=yZaFU/XUDZWK/fAPzb0mNSaNhmOBN1uRs0vtFftJ4dc6rHe0iz2CfLwQMa3xTLgqhdTr
 dCWnIieBz8cb7JKRebKtDsz9W/l/2rK2XVtpi70KZi6a4craCeruiQfs1kqfMCTklvJH
 NqvBtHBd4z3xEib2agRPhIvnJNyL7aDYBdGJyzBiUs3ocpwqwa4IqaYIJvMvs/nz2vM8
 DOp8Ktwi7i8dGGVCKc3+xscgNFN1V458aXTu96jEoLcphURDk/Isg0My2ScBexJdEed3
 mnzl96qTouky/J0z999TWBkyVdD3x4tdOqkEK8hBS09KybxSW+6yIF/pCNbaJ9p/ry9O Fw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 30fsgm0byd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 04:08:56 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 03M48MVT174286;
        Wed, 22 Apr 2020 04:08:56 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 30gb1hhxs0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 22 Apr 2020 04:08:55 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 03M48sTB032389;
        Wed, 22 Apr 2020 04:08:55 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 21 Apr 2020 21:08:54 -0700
To:     Jason Yan <yanaijie@huawei.com>
Cc:     <sathya.prakash@broadcom.com>, <chaitra.basappa@broadcom.com>,
        <suganath-prabu.subramani@broadcom.com>, <jejb@linux.ibm.com>,
        <martin.petersen@oracle.com>, <sreekanth.reddy@broadcom.com>,
        <MPT-FusionLinux.pdl@broadcom.com>, <linux-scsi@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] scsi: mpt3sas: use true,false for bool variables
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20200421034101.28273-1-yanaijie@huawei.com>
Date:   Wed, 22 Apr 2020 00:08:51 -0400
In-Reply-To: <20200421034101.28273-1-yanaijie@huawei.com> (Jason Yan's message
        of "Tue, 21 Apr 2020 11:41:01 +0800")
Message-ID: <yq1v9lsgo18.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=999 mlxscore=0 malwarescore=0 bulkscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2003020000
 definitions=main-2004220031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9598 signatures=668686
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 malwarescore=0 clxscore=1011
 spamscore=0 bulkscore=0 phishscore=0 suspectscore=0 impostorscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2003020000 definitions=main-2004220031
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Jason,

> Fix the following coccicheck warning:
>
> drivers/scsi/mpt3sas/mpt3sas_base.c:416:6-14: WARNING: Assignment of 0/1
> to bool variable
> drivers/scsi/mpt3sas/mpt3sas_base.c:485:2-10: WARNING: Assignment of 0/1
> to bool variable

Applied to 5.8/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
