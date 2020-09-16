Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B565D26B8B5
	for <lists+linux-scsi@lfdr.de>; Wed, 16 Sep 2020 02:49:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgIPAtW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 15 Sep 2020 20:49:22 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:49202 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727277AbgIPAtV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 15 Sep 2020 20:49:21 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G0n37D044117;
        Wed, 16 Sep 2020 00:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=Wpugk+2X4lKYTSUhznNeH62d8GptChzAALdIAX5yH4M=;
 b=OreGxmyp7u0pJXZnrDSw4H3kPCCPUFqIAYAt8XNAytEPV1CXDuYdycYjbY1496j+NYDF
 uBW5S8jJqArC0ZI867L6MHpkbLs6eR1sXrnp4THEAqJR1scjTJbHF1rTli+RNyyQHiqw
 v6g1GDCFTxcaFzuwrsrxH2H7CwFqr03KUadruKnxS7ClC9bBk/S7hEjkVKuVHTiBowD3
 mz4sAo9ZlymljhB8FNabiEPlL93whQrtUaYCUPEQQ+YCcBcsKV5Wkb97d46+YUhvurQU
 PUQ8QNTuSkLwqWe9FcTTrogIj6Z2MjhbRUqB8ffkth4uVxgCAPcBY+UOIc4ndP4pwAcG LQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 33gp9m86dg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 16 Sep 2020 00:49:14 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08G0Uj2t151445;
        Wed, 16 Sep 2020 00:49:14 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 33h890bp29-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 16 Sep 2020 00:49:14 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08G0nBFB005132;
        Wed, 16 Sep 2020 00:49:12 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 16 Sep 2020 00:49:11 +0000
To:     Brian King <brking@linux.vnet.ibm.com>
Cc:     linux-scsi@vger.kernel.org, tyreld@linux.ibm.com,
        linuxppc-dev@lists.ozlabs.org, martin.petersen@oracle.com
Subject: Re: [PATCH] ibmvfc: Avoid link down on FS9100 canister reboot
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1o8m61r87.fsf@ca-mkp.ca.oracle.com>
References: <1599859706-8505-1-git-send-email-brking@linux.vnet.ibm.com>
Date:   Tue, 15 Sep 2020 20:49:09 -0400
In-Reply-To: <1599859706-8505-1-git-send-email-brking@linux.vnet.ibm.com>
        (Brian King's message of "Fri, 11 Sep 2020 16:28:26 -0500")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 spamscore=0 adultscore=0
 suspectscore=1 mlxscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160001
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9745 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 mlxlogscore=999
 adultscore=0 malwarescore=0 clxscore=1011 lowpriorityscore=0 phishscore=0
 spamscore=0 priorityscore=1501 suspectscore=1 impostorscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009160002
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Brian,

> When a canister on a FS9100, or similar storage, running in NPIV mode,
> is rebooted, its WWPNs will fail over to another canister.

[...]

Applied to 5.10/scsi-staging, thanks! I fixed a bunch of checkpatch
warnings.

-- 
Martin K. Petersen	Oracle Linux Engineering
