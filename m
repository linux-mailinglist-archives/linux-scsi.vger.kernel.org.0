Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB12E1DE
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 14:05:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfD2MFX (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 08:05:23 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:50782 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727913AbfD2MFX (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 08:05:23 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TBxJJT174560;
        Mon, 29 Apr 2019 12:05:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=xUvl2SPB2X0dUuopnAjsh5ZHm25YmIphDJSWE6O6ScM=;
 b=iyYve8qcTjJqN5dTuocVEuEAv2PD8q7WvPs0QXfEIfLzCbTVxxLGhkz8jueczxLIZHnv
 6638lu7u7hK5uddEa/y3G9bU3N6lD3Z8B2wJxWkzJEfFvW7Z4u1JwR9ju60OnNBXuodc
 hTwzkSKrfVm37yprwQbVMIMf8TeY4+ZhSfXPyGrjidmWX8PvN8M99/c8peo9tBv7MbET
 3U4GTs9xQIe3Z3PelYOoHePOShEh/IJF88BoTHVhtHgI+zvtxGx9GkoLgBhYrQX0H33x
 gOfAgxNn1dc2qBYzc/znIqUKtD0qXhN9e3GOHTX1ZPnyjHpJYPgBTuVEMHBBMEkXCV7J jQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2s5j5ttk1e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 12:05:18 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TC3Zr8126618;
        Mon, 29 Apr 2019 12:05:18 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2s4yy8xan7-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 12:05:18 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3TC5HPg027032;
        Mon, 29 Apr 2019 12:05:17 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 05:05:16 -0700
To:     Himanshu Madhani <hmadhani@marvell.com>
Cc:     <James.Bottomley@HansenPartnership.com>,
        <martin.petersen@oracle.com>, <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/2] qla2xxx: Minor fixes
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190423215236.13664-1-hmadhani@marvell.com>
Date:   Mon, 29 Apr 2019 08:05:14 -0400
In-Reply-To: <20190423215236.13664-1-hmadhani@marvell.com> (Himanshu Madhani's
        message of "Tue, 23 Apr 2019 14:52:34 -0700")
Message-ID: <yq1imux10g5.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=999
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290088
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290088
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Himanshu,

> These patches fix small issue where device stays in blocked state due
> to driver not marking port offline and moving debug message to correct
> verbose level.
>
> Please apply to 5.2/scsi-queue branch for inclusion at your earliest
> convenience.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
