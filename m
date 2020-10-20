Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2F151286CB3
	for <lists+linux-scsi@lfdr.de>; Thu,  8 Oct 2020 04:22:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728023AbgJHCV4 (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 7 Oct 2020 22:21:56 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:60426 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727605AbgJHCVy (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 7 Oct 2020 22:21:54 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0982LkeA182285;
        Thu, 8 Oct 2020 02:21:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : message-id : references : date : in-reply-to : mime-version :
 content-type; s=corp-2020-01-29;
 bh=zcmG44xznlrg+QSPUoqWB8ND72BytUbbk4I58Oj+LC8=;
 b=LFelTi/M2PL42w+BrVyo6Z40VPH5kJ4x+PKH3aa5rI19vxg8Gn97Bt1amOJNGZYq0+Z4
 FqnH2JpXl0Y55kX8xqeMGRd+Lw116yHGfkBoXMXIHyqu/YRnPQhy9fNnP6CSFaBEwBgo
 Bd/4nNPbkf1pFXHFzl8oe7uzDX2skAkOf0bb7jueFQDfLncnz9klQ3shs+ywLEuiZwGT
 ITS/R8JHx2sflm6P+/iAuzgl8iCHcDQCKi5FrkBEZUmhZLC6Hm1Q6CVR8V7t+s++3+LZ
 bI7DGiKGHCuJPbMXYkSpyArFzyKp2OEcrw4bVD1WiqzJTVi36PZuHenxLn9ti3PpY7Ug 4g== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 33xetb5aaf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 08 Oct 2020 02:21:46 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0982KDS6031217;
        Thu, 8 Oct 2020 02:21:45 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 33y380bxgn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 08 Oct 2020 02:21:45 +0000
Received: from abhmp0012.oracle.com (abhmp0012.oracle.com [141.146.116.18])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0982Likc003339;
        Thu, 8 Oct 2020 02:21:44 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 07 Oct 2020 19:21:44 -0700
To:     trix@redhat.com
Cc:     njavali@marvell.com, jejb@linux.ibm.com,
        martin.petersen@oracle.com, natechancellor@gmail.com,
        ndesaulniers@google.com, GR-QLogic-Storage-Upstream@marvell.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: Re: [PATCH] scsi: qla2xxx: initialize value
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
Message-ID: <yq1d01tzcdf.fsf@ca-mkp.ca.oracle.com>
References: <20201005144544.25335-1-trix@redhat.com>
Date:   Wed, 07 Oct 2020 22:21:41 -0400
In-Reply-To: <20201005144544.25335-1-trix@redhat.com> (trix@redhat.com's
        message of "Mon, 5 Oct 2020 07:45:44 -0700")
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 phishscore=0 bulkscore=0 spamscore=0
 mlxscore=0 malwarescore=0 suspectscore=3 adultscore=0 mlxlogscore=667
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080019
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9767 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxscore=0
 clxscore=1011 priorityscore=1501 adultscore=0 mlxlogscore=699 phishscore=0
 impostorscore=0 malwarescore=0 suspectscore=3 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2010080019
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Tom,

> clang static analysis reports this problem:
>
> qla_nx2.c:694:3: warning: 6th function call argument is
>   an uninitialized value
>         ql_log(ql_log_fatal, vha, 0xb090,
>         ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Applied to 5.10/scsi-staging, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
