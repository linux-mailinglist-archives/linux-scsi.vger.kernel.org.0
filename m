Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8E640C2C45
	for <lists+linux-scsi@lfdr.de>; Tue,  1 Oct 2019 05:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731847AbfJADNQ (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 30 Sep 2019 23:13:16 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:58442 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727669AbfJADNQ (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 30 Sep 2019 23:13:16 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9134nr7086460;
        Tue, 1 Oct 2019 03:13:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2019-08-05;
 bh=dwSa82ZTQB2MNTQwe5FDYXOvuU8rmN8sPSKl5n2+o1E=;
 b=Io39ChJ62Q94sm4pGx6OWTLnuO+CwgmDhLeFsIoCTouT4T1XkTpVAooGJfs3eNpGEr1u
 9V/HAylROPayn4nu78mleE0Id/4guwzSOY2QLPKLLA2+dqSS+nNmNWnZ85sjIO6G6td2
 4ye94/MiICsAr3kLuOumeLBG11aNe6Ri8feeWCH+N5OboBcutGUXP63er20oh/r0Xtc9
 mXrF7lfiNHWAIsgPIgHquQOs1CFFNRv1HS/rM/b8CY0jZhuVgvsnOh0oneNPmhRalf/7
 QaVzY52w5HlFz6tsCdIwam8hWtuhCsE+MLTUcRjpqZpVxzLHPX9nkfq+3VqboMxQ+H9+ 4Q== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 2v9yfq2wee-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 03:13:03 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x9138iBp082963;
        Tue, 1 Oct 2019 03:13:03 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3020.oracle.com with ESMTP id 2vbnqbw5fb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 01 Oct 2019 03:13:02 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x913CxT2019247;
        Tue, 1 Oct 2019 03:13:00 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 30 Sep 2019 20:12:59 -0700
To:     Colin King <colin.king@canonical.com>
Cc:     Don Brace <don.brace@microsemi.com>,
        "James E . J . Bottomley" <jejb@linux.ibm.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        esc.storagedev@microsemi.com, linux-scsi@vger.kernel.org,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] scsi: smartpqi: clean up an indentation issue
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190927095840.26377-1-colin.king@canonical.com>
Date:   Mon, 30 Sep 2019 23:12:57 -0400
In-Reply-To: <20190927095840.26377-1-colin.king@canonical.com> (Colin King's
        message of "Fri, 27 Sep 2019 10:58:40 +0100")
Message-ID: <yq15zl9xio6.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=716
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1908290000 definitions=main-1910010031
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9396 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=814 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1908290000
 definitions=main-1910010031
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Colin,

> There are some statements that are indented too deeply, remove the
> extraneous tabs and rejoin split lines.

Applied (additional hunk) to 5.5/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
