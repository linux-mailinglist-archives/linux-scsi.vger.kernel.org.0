Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 717AC247C7E
	for <lists+linux-scsi@lfdr.de>; Tue, 18 Aug 2020 05:11:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726656AbgHRDLs (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 17 Aug 2020 23:11:48 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:33530 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgHRDLr (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 17 Aug 2020 23:11:47 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07I36u9w113691;
        Tue, 18 Aug 2020 03:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=KjjcL75V0/m+1nWGWd2tOjdENPU5ZqoRW8Bh9qm/BFE=;
 b=GWrVgA+t6CeMNgcT4KKQdbzRcki3G1e1dn7IpFfvdUF5spnXKgS8bb5QIb1vng3vlGlv
 PAJGGh07tO4m39CUmwL1Ka/5irBmt+OTIe6UqPhAZM71iXApuwEbOmgqGpXTepoONr4V
 CKN7JmfegsJdINZxjct4WodkQYcgAwCdvWGUtK74MSC+Tpffowjreq11Ipy1Iyb2D6wn
 /9ax1snB+D8tdqEO4hgSpVbTMX7BGbkbAkr0zLx3wuzDVCSE1cuExSDg/PISQRIrKSwz
 YENNbreTPGfY32TuFWQJUSU7cRn5SwbyQbv4trg3+w0UMw976wZElRStTIaaFOqXs4Cp yQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 32x8bn22k9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 18 Aug 2020 03:11:21 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 07I38tug134334;
        Tue, 18 Aug 2020 03:11:20 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 32xsmwp4xt-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 18 Aug 2020 03:11:20 +0000
Received: from abhmp0020.oracle.com (abhmp0020.oracle.com [141.146.116.26])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 07I3BIk5021978;
        Tue, 18 Aug 2020 03:11:18 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 17 Aug 2020 20:11:17 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Kevin.Barnett@microchip.com, hch@infradead.org,
        jejb@linux.vnet.ibm.com, joseph.szczypek@hpe.com,
        Justin.Lindley@microchip.com, bader.alisaleh@microchip.com,
        scott.teel@microchip.com, gerry.morong@microchip.com,
        POSWALD@suse.com, Don Brace <don.brace@microsemi.com>,
        scott.benesh@microchip.com, mahesh.rajashekhara@microchip.com
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH 0/7] smartpqi updates
Date:   Mon, 17 Aug 2020 23:11:11 -0400
Message-Id: <159772022967.19349.14005779725486000073.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <159622890296.30579.6820363566594432069.stgit@brunhilda>
References: <159622890296.30579.6820363566594432069.stgit@brunhilda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9716 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 bulkscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 suspectscore=0 adultscore=0
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

On Fri, 31 Jul 2020 16:01:05 -0500, Don Brace wrote:

> These patches are based on Linus's tree
> 
> The changes are:
> smartpqi-identify-physical-devices-without-issuing-INQUIRY
>  - eliminate sending INQUIRYs to physical devices
> smartpqi-add-id-support-for-smartRAID-3152-8i
>  - add support for a new controller
> smartpqi-update-logical-volume-size-after-expansion
>  - update volume size in OS after expansion.
> smartpqi-avoid-crashing-kernel-for-controller-issues
>  - remove BUG calls for rare cases when controller returns
>    bad responses.
> smartpqi-support-device-deletion-via-sysfs
>  - handle device removal using sysfs file
>    /sys/block/sd<X>/device/delete where X is device name is a, b, ...
> smartpqi-add-RAID-bypass-counter
>  - aid to identify when RAID bypass is in use.
> smartpqi-bump-version-to-1.2.16-010

Applied to 5.10/scsi-queue, thanks!

[1/7] scsi: smartpqi: Identify physical devices without issuing INQUIRY
      https://git.kernel.org/mkp/scsi/c/79d98a09024f
[2/7] scsi: smartpqi: Add id support for SmartRAID 3152-8i
      https://git.kernel.org/mkp/scsi/c/0451304e8e8e
[3/7] scsi: smartpqi: Update logical volume size after expansion
      https://git.kernel.org/mkp/scsi/c/9e0ab6e5b185
[4/7] scsi: smartpqi: Avoid crashing kernel for controller issues
      https://git.kernel.org/mkp/scsi/c/d4f7505924ca
[5/7] scsi: smartpqi: Support device deletion via sysfs
      https://git.kernel.org/mkp/scsi/c/a5a3cb83cf3a
[6/7] scsi: smartpqi: Add RAID bypass counter
      https://git.kernel.org/mkp/scsi/c/bdd6dac631bc
[7/7] scsi: smartpqi: Bump version to 1.2.16-010
      https://git.kernel.org/mkp/scsi/c/441c5e632c1b

-- 
Martin K. Petersen	Oracle Linux Engineering
