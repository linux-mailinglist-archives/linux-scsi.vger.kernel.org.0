Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 158A2579B1
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 04:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726990AbfF0CvE (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 22:51:04 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:44626 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726762AbfF0CvE (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Jun 2019 22:51:04 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R2nkMN067077;
        Thu, 27 Jun 2019 02:50:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=BXNZu2kIZV5mPU1BKZ6CDqoTZvg2cWw9JnnZY2jWA5Q=;
 b=uZDIqHcM/bxCrC3aLX710LR6O+rc6tmv32UlWjTyaWVxZFe1CVp404uRCsN4cpLqLMyJ
 G67STszIHBujIynPVc4FuxCVguXw+SzoeMe/d7SnBgfX9Nt1y3zV6x7aKQ/1M/6u+wmy
 QfEWHWnGipiwD28ckBdRSMEFOqoI1XZdCJKsxJckwvdGQiKiGTD9mcdD8jyAQG8khugD
 k1sqTh1A71FkI7LHW0CC6MZ5ro6+luSCu6Yr56DxOJy7Zkc+GD87+M+rz30Y6N7e5gdd
 D/e0NYvVblIpTVIZzzjkobcNuYjVBHSLpS0tAA0BdoV1r7YnDY89tc0XniTwv8PWBZSz AA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2t9cyqngq8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 02:50:48 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R2mmF2133416;
        Thu, 27 Jun 2019 02:48:48 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 2tat7d4u5s-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 02:48:48 +0000
Received: from abhmp0015.oracle.com (abhmp0015.oracle.com [141.146.116.21])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5R2maE2027809;
        Thu, 27 Jun 2019 02:48:36 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 19:48:35 -0700
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>
Cc:     "James E . J . Bottomley" <jejb@linux.vnet.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-@vger.kernel.org,
        kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bean Huo <beanhuo@micron.com>,
        Stanley Chu <stanley.chu@mediatek.com>,
        Doug Anderson <dianders@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>,
        Arthur Simchaev <Arthur.Simchaev@sandisk.com>
Subject: Re: [PATCH] Documentation: scsi: ufs: announce ufs-tool v1.0
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1561466160-13512-1-git-send-email-Arthur.Simchaev@wdc.com>
Date:   Wed, 26 Jun 2019 22:48:31 -0400
In-Reply-To: <1561466160-13512-1-git-send-email-Arthur.Simchaev@wdc.com>
        (Arthur Simchaev's message of "Tue, 25 Jun 2019 15:36:00 +0300")
Message-ID: <yq136jvlp4w.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=860
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=915 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270031
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Arthur,

> +The user-space tool that interacts with the ufs-bsg endpoint and uses its
> +upiu-based protocol, is available at
> +https://github.com/westerndigitalcorporation/ufs-tool.

Applied to 5.3/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
