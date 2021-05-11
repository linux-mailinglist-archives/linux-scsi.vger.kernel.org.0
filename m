Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CB1E637AE26
	for <lists+linux-scsi@lfdr.de>; Tue, 11 May 2021 20:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232019AbhEKSOA (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 11 May 2021 14:14:00 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:1760 "EHLO
        mx0b-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231462AbhEKSN7 (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>);
        Tue, 11 May 2021 14:13:59 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.43/8.16.0.43) with SMTP id 14BI3edp026115;
        Tue, 11 May 2021 14:12:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=from : to : cc : subject
 : date : message-id; s=pp1;
 bh=PX0ONcdSKl6Jkyr4bxfDBKGnSrhTnfXbM0OEBbUe+Mg=;
 b=j6Du+mX1R3REh58YcaQJYQGpcPllTWRhZLOShabI1OZGsDo25jiO2pCzptUMy1T//X5S
 Nv3OAeo5BqJPgBzf0uW111S1EzgY3iwrlKAXPyGVvWoGv1caJ1pMxSNZASUpsliSx6Nx
 jXMM/rlL+pFlMwl79QRx9Suw2mSC6r7xcF0pnE0Fa136FnTO8HizSRWfiuWE1fEK+bkg
 ampOqklGPV1Fud+c1hSV8ystHxjfbgKLfc6HTOw229Yk+EW5M7QbQGqwiGzfwxJBXVA7
 RT3ZRLVWsrFmv6NBOPiaOy4GD9tz4VCJ3SgD2Tt/zJ56XXCw8YxDepCi2mfZ8rlyOVGN Sg== 
Received: from ppma05wdc.us.ibm.com (1b.90.2fa9.ip4.static.sl-reverse.com [169.47.144.27])
        by mx0a-001b2d01.pphosted.com with ESMTP id 38fx569hb8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 14:12:48 -0400
Received: from pps.filterd (ppma05wdc.us.ibm.com [127.0.0.1])
        by ppma05wdc.us.ibm.com (8.16.0.43/8.16.0.43) with SMTP id 14BICILM009461;
        Tue, 11 May 2021 18:12:48 GMT
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com [9.57.198.25])
        by ppma05wdc.us.ibm.com with ESMTP id 38fu1xsn6y-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 May 2021 18:12:48 +0000
Received: from b01ledav002.gho.pok.ibm.com (b01ledav002.gho.pok.ibm.com [9.57.199.107])
        by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 14BICl5g29753672
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 11 May 2021 18:12:48 GMT
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id D3AEC12406C;
        Tue, 11 May 2021 18:12:46 +0000 (GMT)
Received: from b01ledav002.gho.pok.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 06776124066;
        Tue, 11 May 2021 18:12:45 +0000 (GMT)
Received: from oc6034535106.ibm.com (unknown [9.211.88.15])
        by b01ledav002.gho.pok.ibm.com (Postfix) with ESMTP;
        Tue, 11 May 2021 18:12:45 +0000 (GMT)
From:   Brian King <brking@linux.vnet.ibm.com>
To:     james.bottomley@hansenpartnership.com
Cc:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        tyreld@linux.ibm.com, Brian King <brking@linux.vnet.ibm.com>
Subject: [PATCH 0/3] ibmvfc: Move login error handling
Date:   Tue, 11 May 2021 13:12:17 -0500
Message-Id: <1620756740-7045-1-git-send-email-brking@linux.vnet.ibm.com>
X-Mailer: git-send-email 1.8.3.1
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: yeEjgnNrP1ZKup5FigXDVadGxbxFIKlC
X-Proofpoint-ORIG-GUID: yeEjgnNrP1ZKup5FigXDVadGxbxFIKlC
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.391,18.0.761
 definitions=2021-05-11_04:2021-05-11,2021-05-11 signatures=0
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 malwarescore=0
 phishscore=0 spamscore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=940 clxscore=1011 suspectscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2104190000
 definitions=main-2105110122
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

This set of patches makes the move login handling in the
ibmvfc driver more robust and resolves some issues seen
in our SAN interop testing.

Brian King (3):
  ibmvfc: Handle move login failure
  ibmvfc: Avoid move login if fast fail is enabled
  ibmvfc: Reinit target retries

 drivers/scsi/ibmvscsi/ibmvfc.c | 60 +++++++++++++++++++++++++++++-------------
 drivers/scsi/ibmvscsi/ibmvfc.h |  3 ++-
 2 files changed, 43 insertions(+), 20 deletions(-)

-- 
1.8.3.1

