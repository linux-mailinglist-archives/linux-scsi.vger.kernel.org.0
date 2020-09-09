Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E8BC262514
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 04:18:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729275AbgIICSG (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 22:18:06 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:46586 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725997AbgIICRz (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 22:17:55 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0892Eh7H110495;
        Wed, 9 Sep 2020 02:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=EBQ4dQGp0FJdw7S0zVu1ZvyVCa7/Er2gExkvGaNJsPo=;
 b=yVqtkMPat1NVm2fyMUR++9YYtV+1A+s/BPKRwHvIEwUDNbLl5BqMU7TU7enE2KRVb5an
 OHUxpJ0LdZX5HQhrfm/1Xj4zOetdXwnnTqkk4xTu9QR1fx6zfrYTAKNXpnwf9qAUUTdZ
 dVxuUObtxwdhfgrladd/ADKJ8zlCAPpXLE/hqodVVtfe5q4amfed9MmYYXBGg6r7dhPf
 /7NhLbBZLcXNBM3xqWLS3h+fRh9MimBEkohyXwI+J0IEX8pujZN02h03ceHRmWd8W8kL
 TlD0MIofuQOyRKOfWHgPM8rI/RCD4xzkh83uOr/DXpF4qzZOY109JswLDmdKa8njXDcx 4w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33c2mkxw9p-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 02:17:46 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0892FRfX026558;
        Wed, 9 Sep 2020 02:17:46 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 33cmerxmv4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 02:17:45 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0892Hins015288;
        Wed, 9 Sep 2020 02:17:45 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 19:17:44 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Li Heng <liheng40@huawei.com>, jejb@linux.ibm.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        MPT-FusionLinux.pdl@broadcom.com, linux-kernel@vger.kernel.org,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH -next 0/3] scsi: Remove superfluous memset()
Date:   Tue,  8 Sep 2020 22:17:29 -0400
Message-Id: <159961781204.6233.14353545728314203436.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <1596079918-41115-1-git-send-email-liheng40@huawei.com>
References: <1596079918-41115-1-git-send-email-liheng40@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 phishscore=0 malwarescore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1011 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090019
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 30 Jul 2020 11:31:55 +0800, Li Heng wrote:

> *** BLURB HERE ***
> 
> Li Heng (3):
>   scsi: Remove superfluous memset()
>   scsi: Remove superfluous memset()
>   scsi: Remove superfluous memset()
> 
> [...]

Applied to 5.10/scsi-queue, thanks!

[1/3] scsi: pmcraid: Remove superfluous memset()
      https://git.kernel.org/mkp/scsi/c/7b1d88629807
[2/3] scsi: qla2xxx: Remove superfluous memset()
      https://git.kernel.org/mkp/scsi/c/bef93fbfcf4a
[3/3] scsi: mpt3sas: Remove superfluous memset()
      https://git.kernel.org/mkp/scsi/c/4a636e9c7a21

-- 
Martin K. Petersen	Oracle Linux Engineering
