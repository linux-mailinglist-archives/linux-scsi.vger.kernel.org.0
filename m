Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ED03666357
	for <lists+linux-scsi@lfdr.de>; Fri, 12 Jul 2019 03:22:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728855AbfGLBWv (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 11 Jul 2019 21:22:51 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:57082 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726587AbfGLBWv (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 11 Jul 2019 21:22:51 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C1IWkE122640;
        Fri, 12 Jul 2019 01:22:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=xQU+hIivwsk9Rgrtj3FTlVDAx40vNslWzQ7vly9iFMo=;
 b=4MLyLJF1v7L46qE3bvdDCqhPczhMgzy6mj0EV2QiD37GqOkHkaCjNi7akQx4ELqVlyfG
 MYq8cL6iJEygj2PMQdCYDWOWIsjx52AbrI9JU0E88bCCYwo/q63llIUusRCO4QMKddS3
 1RdRC5uDszASR/VpDYBzoKj0o1R8511F7FNv6iq/oe/6POYOt5tkq+C1HdxpJFZsovqX
 XZ4oU0D2n8wORtsO5I+IGg0zScJ7cAPbbhLWwR6kzwyAvber22sl5EUEtQNwWYDhTcZz
 cGduXHyNlIOXTBMlT8KeJ5W+neHs9f3Pmli0lSJKdyWmrYEz/eLZz4z/NgsQPfa8GNOu Vw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2120.oracle.com with ESMTP id 2tjm9r2xy0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:22:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6C1MaY8159282;
        Fri, 12 Jul 2019 01:22:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2tn1j1vbpm-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 12 Jul 2019 01:22:41 +0000
Received: from abhmp0004.oracle.com (abhmp0004.oracle.com [141.146.116.10])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6C1MVF7007771;
        Fri, 12 Jul 2019 01:22:31 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 11 Jul 2019 18:22:31 -0700
To:     James Bottomley <jejb@linux.vnet.ibm.com>
Cc:     "Martin K. Petersen" <martin.petersen@oracle.com>,
        Avri Altman <avri.altman@wdc.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avi Shchislowski <avi.shchislowski@wdc.com>,
        Alex Lemberg <alex.lemberg@wdc.com>
Subject: Re: [PATCH] scsi: uapi: ufs: Fix SPDX license identifier
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1560346477-13944-1-git-send-email-avri.altman@wdc.com>
        <yq1ef2w9kig.fsf@oracle.com>
        <1562890815.2915.13.camel@linux.vnet.ibm.com>
Date:   Thu, 11 Jul 2019 21:22:28 -0400
In-Reply-To: <1562890815.2915.13.camel@linux.vnet.ibm.com> (James Bottomley's
        message of "Thu, 11 Jul 2019 17:20:15 -0700")
Message-ID: <yq1d0ig6o8b.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=852
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907120016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9315 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=899 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907120015
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


James,

> Just to note: this isn't technically a licence change at all.  The
> entire kernel is covered by the system call exception and this file is
> thus also covered.  It's really a simple tag change to allow tools
> which parse uapi header files to recognise from the SPDX tags that this
> is a kernel header to which the Linux-syscall-note applies.

OK.

-- 
Martin K. Petersen	Oracle Linux Engineering
