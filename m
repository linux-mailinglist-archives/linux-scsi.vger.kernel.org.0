Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 14B07221798
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Jul 2020 00:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGOWOo (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 15 Jul 2020 18:14:44 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:33234 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGOWOo (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 15 Jul 2020 18:14:44 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FMCAoO045272;
        Wed, 15 Jul 2020 22:14:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=8sHwCXaJlPee7iaeG7qRDAiXL2dPUm4R5r4YOc9GKEE=;
 b=vkhBKsVBn+EE8FWIht7/Jug5Bx4vboNZDqgBqO+uSXEdFRuzhVv3KBUh1tRy9rVZEH4w
 gj9Rw8I235B2YY6AwsuLN7TOFujXmUMw2b8lS/M0JdTDoht8pJ030LvQeaQNG1GRBC2r
 h7h1qTjKxEyX0Dt6SrO4CYd68+4ptRguNSKUMYcamn7k6A7Jy0rh0RADCr6q+nNV5Jpc
 zYjGYU2XorhntDpkuxD93KkJFACp+pIvtCj9HABZkryCEQjgKgN00yy9XHVzQD+GHAHk
 s/qFprD4VWgGNXncx3HZVHX9Ds0NJGIVH+0zhQihBLheUH9tc4HfgGdOrY9+2LhL4KKw gA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 3274ure3hm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 15 Jul 2020 22:14:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06FMDeMU086762;
        Wed, 15 Jul 2020 22:14:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 32a4cretjj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 15 Jul 2020 22:14:41 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 06FMEebg025161;
        Wed, 15 Jul 2020 22:14:40 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 15 Jul 2020 15:14:39 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     James Smart <jsmart2021@gmail.com>, linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Martin George <Martin.George@netapp.com>
Subject: Re: [PATCH] lpfc: nvme remote port devloss_tmo from lldd
Date:   Wed, 15 Jul 2020 18:14:32 -0400
Message-Id: <159484884354.21107.6383523575322246851.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200714211412.11773-1-jsmart2021@gmail.com>
References: <20200714211412.11773-1-jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999 spamscore=0
 suspectscore=0 bulkscore=0 adultscore=0 phishscore=0 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150165
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9683 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 phishscore=0 spamscore=0 mlxlogscore=999 malwarescore=0
 mlxscore=0 priorityscore=1501 adultscore=0 bulkscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007150165
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 14 Jul 2020 14:14:12 -0700, James Smart wrote:

> Nvme-fc allows the driver to specify a default devloss_tmo value when
> registering the remote port. The lpfc driver is currently not doing so
> although it is implementing a driver internal node loss value of 30s
> which also is used on the scsi fc remote port. As no devloss_tmo is set,
> the nvme-fc transport defaults to 60s. So there's competing timers.
> 
> Additionally, due to the competing timers, its possible the nvme rport
> is removed but the scsi rport remains. Its possible that the scsi fc
> rport, which was registered for the nvme port even if it doesn't utilize
> the scsi protocol, had been tuned to not match either the 60s (nvme-fc
> default) or 30s (lldd default), it gets out of whack. The lldd will
> defer to the scsi fc rport as long as the scsi fc rport has not had its
> devloss_tmo expire.
> 
> [...]

Applied to 5.9/scsi-queue, thanks!

[1/1] scsi: lpfc: NVMe remote port devloss_tmo from lldd
      https://git.kernel.org/mkp/scsi/c/1f5468231476

-- 
Martin K. Petersen	Oracle Linux Engineering
