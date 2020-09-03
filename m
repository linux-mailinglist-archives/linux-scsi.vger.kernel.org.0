Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A18CA25B8FE
	for <lists+linux-scsi@lfdr.de>; Thu,  3 Sep 2020 05:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgICDBm (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 2 Sep 2020 23:01:42 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:51376 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgICDBl (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 2 Sep 2020 23:01:41 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0832wx69043490;
        Thu, 3 Sep 2020 03:01:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=0Z1q5qiHMD8+2qYROIahHXCALv8R3DX7E2qOm1esaF8=;
 b=MBrKTg3U41AiPVBHFrJdR9Plq1beUG0u4mlmkIOxWGEmHu8cMJ4Qz84YY27WhFKisnOU
 FlD9VOWRqa/l4hjwFybTtzUTOayF5U+L256fwthbMYnah2JRoTPrz9rtw9mInSgseQYx
 18MtM3dlOI5wx7VdIBhxiHWuFSkuN69F44WJ3t1zH4lQd3VH/vsfhWxnC8733vTFW2W2
 eMjaOgAcnjbln9n+BOwn5eHc4Q9/sN1dN/353/ukhew/muVMww2LqPFvXUTskdwQtMge
 pWwhEwf+els3yBaLOeZBgjtlHnaoKxlgwKOXuygiaj56Inj38IPCgLQ2IeyiaIC5MfWa xw== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2130.oracle.com with ESMTP id 337eer67m5-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 03 Sep 2020 03:01:14 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0832tGbp175880;
        Thu, 3 Sep 2020 03:01:13 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by aserp3030.oracle.com with ESMTP id 3380kr1d5v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 03 Sep 2020 03:01:13 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08331BS1002139;
        Thu, 3 Sep 2020 03:01:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 02 Sep 2020 20:01:11 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Rene Rebe <rene@exactcode.com>, linux-scsi@vger.kernel.org
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Himanshu Madhani <himanshu.madhani@oracle.com>,
        Bart Van Assche <bvanassche@acm.org>
Subject: Re: [PATCH v3] fix qla2xxx regression on sparc64
Date:   Wed,  2 Sep 2020 23:01:02 -0400
Message-Id: <159910202092.23499.8078072900058407334.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200827.222729.1875148247374704975.rene@exactcode.com>
References: <20200827.222729.1875148247374704975.rene@exactcode.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 mlxscore=0 suspectscore=0 malwarescore=0 mlxlogscore=670 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030027
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9732 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 clxscore=1011 priorityscore=1501
 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0 mlxscore=0
 phishscore=0 impostorscore=0 mlxlogscore=668 bulkscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009030027
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Thu, 27 Aug 2020 22:27:29 +0200 (CEST), Rene Rebe wrote:

> Commit 98aee70d19a7e3203649fa2078464e4f402a0ad8 in 2014 broke qla2xxx
> on sparc64, e.g. as in the Sun Blade 1000 / 2000. Unbreak by partial
> revert to fix endianess in nvram firmware default initialization. Also
> mark the second frame_payload_size in nvram_t __le16 to avoid new
> sparse warnings.

Applied to 5.9/scsi-fixes, thanks!

[1/1] scsi: qla2xxx: Fix regression on sparc64
      https://git.kernel.org/mkp/scsi/c/2a87d485c4cb

-- 
Martin K. Petersen	Oracle Linux Engineering
