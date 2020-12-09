Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9C22D47F0
	for <lists+linux-scsi@lfdr.de>; Wed,  9 Dec 2020 18:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730386AbgLIRYc (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 9 Dec 2020 12:24:32 -0500
Received: from aserp2120.oracle.com ([141.146.126.78]:60344 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731424AbgLIRYV (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 9 Dec 2020 12:24:21 -0500
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9HJSMb111569;
        Wed, 9 Dec 2020 17:23:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=O3Pupwi7ZGQhD0ZmyIFflO7qZgfz88NmGvswkWzghIc=;
 b=gTz6fntGMCfJKc44xRKdgqldvDiQ6RqqWWL1XZhbajJOqDdkuj3fG2wtjQVr/QK/y4Wb
 VrpRruBYm0IJ98ATjA2++TNH/H1+fzU87Q+mI0JDNTmEku7XegawjqrpXCYQB1Ljvr9Q
 TABCUIbwha8poKLmyb16MKMZsvStGPgy5QPqGoOC6VKjfsy75vkU7nnLqeCRNjL/2kpa
 d5S/rXfINs4/zuXS/beUf5hHwsq+BApA/OdfdX4GkJDBidJtN9fyM+8NBycH8Xh4A/eX
 KjUb+ckxxZKBJ6PLlb8us4XJ6viDrf0OyAQD5u6IroRVlvAtptlDSRa24y+ScicUlrII Zw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2120.oracle.com with ESMTP id 35825m9csk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 09 Dec 2020 17:23:30 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0B9HJlsN075744;
        Wed, 9 Dec 2020 17:23:30 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 358m50wgkg-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 09 Dec 2020 17:23:30 +0000
Received: from abhmp0013.oracle.com (abhmp0013.oracle.com [141.146.116.19])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 0B9HNS75017656;
        Wed, 9 Dec 2020 17:23:28 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 09 Dec 2020 09:23:28 -0800
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Finn Thain <fthain@telegraphics.com.au>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-kernel@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Michael Schmitz <schmitzmic@gmail.com>,
        linux-scsi@vger.kernel.org
Subject: Re: [PATCH v3] scsi: NCR5380: Remove context check
Date:   Wed,  9 Dec 2020 12:23:13 -0500
Message-Id: <160753457755.14816.7863858983010100701.b4-ty@oracle.com>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201206075157.19067-1-a.darwish@linutronix.de>
References: <alpine.LNX.2.23.453.2012051512300.6@nippy.intranet> <20201206075157.19067-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 spamscore=0 suspectscore=0
 bulkscore=0 malwarescore=0 phishscore=0 adultscore=0 mlxlogscore=999
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090122
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9829 signatures=668683
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 bulkscore=0
 phishscore=0 mlxlogscore=999 clxscore=1015 priorityscore=1501 mlxscore=0
 spamscore=0 lowpriorityscore=0 malwarescore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2012090122
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Sun, 6 Dec 2020 08:51:57 +0100, Ahmed S. Darwish wrote:

> NCR5380_poll_politely2() uses in_interrupt() and irqs_disabled() to
> check if it is safe to sleep.
> 
> Such usage in drivers is phased out and Linus clearly requested that
> code which changes behaviour depending on context should either be
> separated, or the context be explicitly conveyed in an argument passed
> by the caller.
> 
> [...]

Applied to 5.11/scsi-queue, thanks!

[1/1] scsi: NCR5380: Remove context check
      https://git.kernel.org/mkp/scsi/c/e7734ef14ead

-- 
Martin K. Petersen	Oracle Linux Engineering
