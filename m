Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1BAFF2624D3
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 04:09:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728507AbgIICJi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 22:09:38 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:55838 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726714AbgIICJh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 22:09:37 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08929O5U130870;
        Wed, 9 Sep 2020 02:09:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=Kz6hw5Fb5ejRzMRyf2ULV4CVeokVe36OeSu4GbFimsA=;
 b=EHlyEH4Mmy+nGh0xveZyr1PIUZdoTjdxHJNBGhkT/nrMv0DoUmBGcO3bGOEfiKOgOYTj
 YuNQAgWW4iNopQfy60Ooz4E2dpaYYTcjaz+jmG/BEAODwOOGm1YkQSsXbuXRrVJBla0J
 Xm2AVDugGwnGIivUBPyqlhRVdtCTd55HSk1LEeRNIDPh6d9Y8mlostWXY47Q5iDpkjET
 LOGsH18AILqwMjK7Pdx3KwsSmvJ3ZQjGO/9gxGzHn+Cn3jV3dtGkAArjeMutguQpNFhQ
 s9GG4GEWbhUrCzy1CsIn2lFdYSsmP5CbYqrEtSKG55m7QXIQLg2LRKFTcwUhBToaN3ET uQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 33c23qy0a1-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 02:09:33 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08926LJg185333;
        Wed, 9 Sep 2020 02:09:33 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 33cmkwwg0w-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 02:09:33 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 08929W5l008018;
        Wed, 9 Sep 2020 02:09:32 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 19:09:32 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     linux-scsi@vger.kernel.org, James Smart <james.smart@broadcom.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: add 256GBit speed setting to scsi fc transport
Date:   Tue,  8 Sep 2020 22:09:13 -0400
Message-Id: <159961731708.5787.11334257070823109587.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200831213518.48409-1-james.smart@broadcom.com>
References: <20200831213518.48409-1-james.smart@broadcom.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 phishscore=0 suspectscore=0
 spamscore=0 mlxlogscore=859 adultscore=0 malwarescore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 priorityscore=1501
 mlxlogscore=891 mlxscore=0 bulkscore=0 suspectscore=0 spamscore=0
 malwarescore=0 phishscore=0 lowpriorityscore=0 clxscore=1015
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090018
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 31 Aug 2020 14:35:18 -0700, James Smart wrote:

> Add 256GBit speed setting to the scsi fc transport.  This speed can be
> reached via FC trunking techniques.

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: fc: Add 256GBit speed setting to SCSI FC transport
      https://git.kernel.org/mkp/scsi/c/2a5c98d2d2fe

-- 
Martin K. Petersen	Oracle Linux Engineering
