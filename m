Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 940CA2A7662
	for <lists+linux-scsi@lfdr.de>; Thu,  5 Nov 2020 05:27:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730078AbgKEE1M (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 4 Nov 2020 23:27:12 -0500
Received: from aserp2130.oracle.com ([141.146.126.79]:50568 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727991AbgKEE1L (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 4 Nov 2020 23:27:11 -0500
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A54JpRx135349;
        Thu, 5 Nov 2020 04:21:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-type : content-transfer-encoding; s=corp-2020-01-29;
 bh=XUOjpJtSYZxUEA8jHWvk/J7T//L3Xiv9BLg5/Ct2raI=;
 b=jmoK/1/3n7mmlLHizVR8nRu25e173rzLMKjNjvguRJ2Q3x0rFeRh6ipmT+3YwS1ZVuCp
 2PFIVYIvyoEkWbvKFOypF1sW2EThCy0b0Inm8E7D2nOy0aV34kTiFih0XxWHLbp3Yu9B
 txHqSojOH3+c5XlcwY14nT1gE8rjbxHELHio3WoatClXGBMbpV05vx2f+Sztykd+HrBN
 a6IwFZp/9YegJfkgLQi4imh5El4+g/1yF7tAbPUZhHsgh+bEbw0NkY6DnG9Opcgl2XOX
 c4d7vDKqBJYBf6Fz7nXArYzVwGtoL/1H1Ixu/syDuOZkcFpjpBkvbPRRtLE450YQoqN+ MQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2130.oracle.com with ESMTP id 34hhb29xum-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 05 Nov 2020 04:21:54 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 0A54L1fK135165;
        Thu, 5 Nov 2020 04:21:53 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 34hw0gneek-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 05 Nov 2020 04:21:53 +0000
Received: from abhmp0008.oracle.com (abhmp0008.oracle.com [141.146.116.14])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 0A54LnYd005051;
        Thu, 5 Nov 2020 04:21:49 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 04 Nov 2020 20:21:49 -0800
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Arnd Bergmann <arnd@kernel.org>, Hannes Reinecke <hare@suse.de>,
        Robert Love <robert.w.love@intel.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        James Bottomley <James.Bottomley@HansenPartnership.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Lee Jones <lee.jones@linaro.org>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] libfc: fix enum-conversion warning
Date:   Wed,  4 Nov 2020 23:21:44 -0500
Message-Id: <160455005255.26277.14867105382604739619.b4-ty@oracle.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201026214911.3892701-1-arnd@kernel.org>
References: <20201026214911.3892701-1-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 mlxlogscore=996
 phishscore=0 bulkscore=0 spamscore=0 malwarescore=0 mlxscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2009150000 definitions=main-2011050030
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9795 signatures=668682
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 phishscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=999 impostorscore=0 malwarescore=0
 lowpriorityscore=0 adultscore=0 spamscore=0 priorityscore=1501 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2009150000
 definitions=main-2011050030
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Mon, 26 Oct 2020 22:49:07 +0100, Arnd Bergmann wrote:

> gcc -Wextra points out an assignment between two different
> enum types:
> 
> drivers/scsi/libfc/fc_exch.c: In function 'fc_exch_setup_hdr':
> ../drivers/scsi/libfc/fc_exch.c:275:26: warning: implicit conversion from 'enum fc_class' to 'enum fc_sof' [-Wenum-conversion]
> 
> This seems to be intentional, as the same numeric values are
> used here, so shut up the warning by adding an explicit cast.

Applied to 5.11/scsi-queue, thanks!

[1/1] scsi: libfc: Fix enum-conversion warning
      https://git.kernel.org/mkp/scsi/c/3fb52041a832

-- 
Martin K. Petersen	Oracle Linux Engineering
