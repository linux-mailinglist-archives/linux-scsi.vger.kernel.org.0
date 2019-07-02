Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A85875D8AB
	for <lists+linux-scsi@lfdr.de>; Wed,  3 Jul 2019 02:27:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727082AbfGCA06 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 2 Jul 2019 20:26:58 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:63984 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726150AbfGCA06 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 2 Jul 2019 20:26:58 -0400
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x62L1hGL048098
        for <linux-scsi@vger.kernel.org>; Tue, 2 Jul 2019 17:02:09 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2tgcry4g50-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-scsi@vger.kernel.org>; Tue, 02 Jul 2019 17:02:09 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-scsi@vger.kernel.org> from <bblock@linux.ibm.com>;
        Tue, 2 Jul 2019 22:02:07 +0100
Received: from b06cxnps3074.portsmouth.uk.ibm.com (9.149.109.194)
        by e06smtp04.uk.ibm.com (192.168.101.134) with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted;
        (version=TLSv1/SSLv3 cipher=AES256-GCM-SHA384 bits=256/256)
        Tue, 2 Jul 2019 22:02:05 +0100
Received: from d06av23.portsmouth.uk.ibm.com (d06av23.portsmouth.uk.ibm.com [9.149.105.59])
        by b06cxnps3074.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id x62L23Ft39190636
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 2 Jul 2019 21:02:03 GMT
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 9F096A4059;
        Tue,  2 Jul 2019 21:02:03 +0000 (GMT)
Received: from d06av23.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 8BDDDA4053;
        Tue,  2 Jul 2019 21:02:03 +0000 (GMT)
Received: from t480-pf1aa2c2 (unknown [9.145.93.34])
        by d06av23.portsmouth.uk.ibm.com (Postfix) with ESMTPS;
        Tue,  2 Jul 2019 21:02:03 +0000 (GMT)
Received: from bblock by t480-pf1aa2c2 with local (Exim 4.92)
        (envelope-from <bblock@linux.ibm.com>)
        id 1hiPuc-0007zX-PN; Tue, 02 Jul 2019 23:02:02 +0200
From:   Benjamin Block <bblock@linux.ibm.com>
To:     "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
Cc:     Benjamin Block <bblock@linux.ibm.com>,
        Steffen Maier <maier@linux.ibm.com>,
        Fedor Loshakov <loshakov@linux.ibm.com>,
        Jens Remus <jremus@linux.ibm.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>, linux-scsi@vger.kernel.org,
        linux-s390@vger.kernel.org
Subject: [PATCH 0/3] zfcp: fixes for the zFCP device driver
Date:   Tue,  2 Jul 2019 23:01:59 +0200
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
x-cbid: 19070221-0016-0000-0000-0000028E9375
X-IBM-AV-DETECTION: SAVI=unused REMOTE=unused XFE=unused
x-cbparentid: 19070221-0017-0000-0000-000032EC284A
Message-Id: <cover.1562098940.git.bblock@linux.ibm.com>
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-07-02_10:,,
 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 malwarescore=0 suspectscore=2 phishscore=0 bulkscore=0 spamscore=0
 clxscore=1015 lowpriorityscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=918 adultscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.0.1-1810050000 definitions=main-1907020233
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

Hello James and Martin,

here are some fixes for the zFCP device driver. I am rather certain this
won't fit into this rc-cycle anymore.. I just found these last week and
with internal reviews and tests I was regrettably not able to post these
any sooner.

So please consider them for the next cycle. Or should I not have send
them in that case? Sorry, this step of the process was a bit unclear to
me.

The first patch is the "most urgent" of the three, although nothing
too terrible happens if we hit it.

Reviews are welcome from everyone, obviously.

Benjamin Block (3):
  zfcp: fix request object use-after-free in send path causing seqno
    errors
  zfcp: fix request object use-after-free in send path causing wrong
    traces
  zfcp: fix GCC compiler warning emitted with -Wmaybe-uninitialized

 drivers/s390/scsi/zfcp_erp.c |  7 +++++
 drivers/s390/scsi/zfcp_fsf.c | 55 +++++++++++++++++++++++++++++++-----
 2 files changed, 55 insertions(+), 7 deletions(-)

-- 
2.17.1

