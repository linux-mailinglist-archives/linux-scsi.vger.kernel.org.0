Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7ABE622D3F0
	for <lists+linux-scsi@lfdr.de>; Sat, 25 Jul 2020 04:53:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727014AbgGYCxU (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Fri, 24 Jul 2020 22:53:20 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:41112 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726592AbgGYCxU (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Fri, 24 Jul 2020 22:53:20 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06P2lAMl077071;
        Sat, 25 Jul 2020 02:53:00 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=6eygxLXkLEOsGThjis+nuk6Mfpue4Arm6KGLp0KMJdw=;
 b=0Hay60+XZsyJpGc2GbJuFFD2Be8BAJON/5syKHh8LmMlujsQTdXh+E1z7oJK7Lic+pe9
 dcP2dWgUNHP+AFAWwmmdonpokuoAdEH08ZXAjfp1ZIi7eLGRQNpusIU03vvEiUkZUS2Y
 Lc/qWfv0r9d+fRsbGVZlDH+5pzfyu2c4MZ3ScTln6dO9B+GgXhQrPEgeYVux7fny2TL3
 mI/unj7gu87A9Y7mvB7aYd8nn2fqlKhVaJfMGmgG+qXXi+Lx65A3cO86WK35Yy8iaLgq
 sxC6XMfJ4L6nijOwiBzyZLo6HorE0hjCpTAJquGmMaG4HiSHk2Ijs3tg8YbrhZZ9LOJh nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 32gc5qr0hf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 25 Jul 2020 02:53:00 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 06P2nBwT024121;
        Sat, 25 Jul 2020 02:50:59 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 32g9uu6pjm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Sat, 25 Jul 2020 02:50:59 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 06P2owsL000902;
        Sat, 25 Jul 2020 02:50:58 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 24 Jul 2020 19:50:57 -0700
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        linux-kernel@vger.kernel.org, James Smart <jsmart2021@gmail.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        linux-scsi@vger.kernel.org,
        Dick Kennedy <dick.kennedy@broadcom.com>
Subject: Re: [PATCH -next] scsi: lpfc: Add dependency on CPU_FREQ
Date:   Fri, 24 Jul 2020 22:50:39 -0400
Message-Id: <159564519422.31464.2450452908669689140.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200722023027.36866-1-linux@roeck-us.net>
References: <20200722023027.36866-1-linux@roeck-us.net>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 suspectscore=0 bulkscore=0 mlxlogscore=969 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007250020
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9692 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 phishscore=0 mlxlogscore=985 spamscore=0 priorityscore=1501 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2007250020
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Tue, 21 Jul 2020 19:30:27 -0700, Guenter Roeck wrote:

> Since commit 317aeb83c92b ("scsi: lpfc: Add blk_io_poll support for
> latency improvment"), the lpfc driver depends on CPUFREQ. Without it,
> builds fail with
> 
> drivers/scsi/lpfc/lpfc_sli.c: In function 'lpfc_init_idle_stat_hb':
> drivers/scsi/lpfc/lpfc_sli.c:7329:26: error:
> 	implicit declaration of function 'get_cpu_idle_time'
> 
> [...]

Applied to 5.9/scsi-queue, thanks!

[1/1] scsi: lpfc: Add dependency on CPU_FREQ
      https://git.kernel.org/mkp/scsi/c/e3d2bf6505dd

-- 
Martin K. Petersen	Oracle Linux Engineering
