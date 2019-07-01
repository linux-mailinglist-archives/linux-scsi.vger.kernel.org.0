Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 622BF2EA4E
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 03:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727261AbfE3Bjx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 21:39:53 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50616 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726527AbfE3Bjx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 21:39:53 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1delr164126;
        Thu, 30 May 2019 01:39:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=IZPrG6xlR4Ydk7vCH2hpd9rccanpG/y7YlNcsJ0kAW8=;
 b=1u4HEthO7kP3Vr9Bjjh9lGVa+OV5oFCvfl7FZNTv4aGeT40UUP0dj5DR0ijJWkmioKfR
 bF+dIJ0m/HropatcDzNzOtEY48Lg3bCdwBTInO34++Oc3suxzGEvzqb9ocRK+I7+CSC4
 MzECfHyZNk1ff/eN8f1mMrNR3ybZYAE5WNrtOozkl/81juITpBiG1u2FrNc8ZpZig1rU
 5+moqnaTvunxRGBgn2t4TfQ5UUflYJ3SBMT2P3Z8ZyBDGQfIgtOLRe8mt1T5dfP+Malv
 Dezlhf2gAg2RrC3cmnTvWQdFX080fZAsdc5++FiR/eMLe1V3cyXw5BjYllmreNOI9HVl 9g== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2130.oracle.com with ESMTP id 2spw4tn98h-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:39:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U1c6h8146064;
        Thu, 30 May 2019 01:39:48 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 2sr31vk9md-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 01:39:48 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U1djDq005700;
        Thu, 30 May 2019 01:39:46 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 18:39:45 -0700
To:     Ondrej Zary <linux@zary.sk>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] fdomain: Add PCMCIA support
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190527201947.6475-1-linux@zary.sk>
Date:   Wed, 29 May 2019 21:39:43 -0400
In-Reply-To: <20190527201947.6475-1-linux@zary.sk> (Ondrej Zary's message of
        "Mon, 27 May 2019 22:19:47 +0200")
Message-ID: <yq1tvdczpnk.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=748
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300011
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=787 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300011
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Ondrej,

> Add PCMCIA card support to Future Domain SCSI driver.
>
> Tested with IBM SCSI PCMCIA Adapter 40G1890.

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
