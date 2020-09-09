Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CE432624D2
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Sep 2020 04:09:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726642AbgIICJi (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 8 Sep 2020 22:09:38 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:41478 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728442AbgIICJh (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 8 Sep 2020 22:09:37 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08920mEe087225;
        Wed, 9 Sep 2020 02:09:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=DgueDwI3BhbtToHvsChXtBSVzaPJf8D4KTxEcnH0dZo=;
 b=wC211yh98fJUUFPyprCGqhCh0e+fLzvl6x6Jim9pQXhPAD7mJZbIgMvelIolaIv0O2SN
 ADU0do/xIwAMzDzEDAfUJSOq9ht5/WGAIRRdLLaublwINJ4rCwjsbmwVkzDwgbhcVYrs
 gmppviV3TYFA1TFJeHAJ62UxZpCVJ/p/LF7eAqgPRr1BZpuOk+7HoCEjKga7jNCS7BCA
 S3MHeNyGuEVMCTdWezHbV4FsjIobx+QrryS12sjoBf3jn8wJZZl6lw4L6XCvr+GxrOA5
 /yjDI5MqnQwwsFC18blF3Mgu/w4Zk2vUGdC/P4y2XuSDWvcm2J40H9PrHn4vQgBPM7IW vw== 
Received: from aserp3020.oracle.com (aserp3020.oracle.com [141.146.126.70])
        by aserp2120.oracle.com with ESMTP id 33c2mkxvmh-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Sep 2020 02:09:32 +0000
Received: from pps.filterd (aserp3020.oracle.com [127.0.0.1])
        by aserp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 089252Hf095311;
        Wed, 9 Sep 2020 02:09:32 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by aserp3020.oracle.com with ESMTP id 33cmk53ejv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Sep 2020 02:09:32 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08929V5t012405;
        Wed, 9 Sep 2020 02:09:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 08 Sep 2020 19:09:31 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>, linux-scsi@vger.kernel.org,
        Avri Altman <avri.altman@wdc.com>,
        Eric Biggers <ebiggers@kernel.org>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>
Subject: Re: [PATCH] scsi: ufs: make ufshcd_print_trs() consider UFSHCD_QUIRK_PRDT_BYTE_GRAN
Date:   Tue,  8 Sep 2020 22:09:12 -0400
Message-Id: <159961731706.5787.492198397343861120.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200826021040.152148-1-ebiggers@kernel.org>
References: <20200826021040.152148-1-ebiggers@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0 malwarescore=0 phishscore=0
 mlxlogscore=999 bulkscore=0 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009090018
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9738 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 priorityscore=1501
 phishscore=0 adultscore=0 bulkscore=0 clxscore=1015 mlxlogscore=999
 malwarescore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009090017
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 25 Aug 2020 19:10:40 -0700, Eric Biggers wrote:

> Fix ufshcd_print_trs() to consider UFSHCD_QUIRK_PRDT_BYTE_GRAN when
> using utp_transfer_req_desc::prd_table_length, so that it doesn't treat
> the number of bytes as the number of entries.
> 
> Originally from Kiwoong Kim
> (https://lkml.kernel.org/r/20200218233115.8185-1-kwmad.kim@samsung.com).

Applied to 5.10/scsi-queue, thanks!

[1/1] scsi: ufs: Make ufshcd_print_trs() consider UFSHCD_QUIRK_PRDT_BYTE_GRAN
      https://git.kernel.org/mkp/scsi/c/cc770ce34aee

-- 
Martin K. Petersen	Oracle Linux Engineering
