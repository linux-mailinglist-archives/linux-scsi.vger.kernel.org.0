Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67DDB20EBF0
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jun 2020 05:23:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729044AbgF3DXW (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Jun 2020 23:23:22 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:43268 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729035AbgF3DXW (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Jun 2020 23:23:22 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05U3I9PE093763;
        Tue, 30 Jun 2020 03:23:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding; s=corp-2020-01-29;
 bh=QkEKs1G4nOwQk9stMmsSiw10VVkVybgTTlbcrUy7lXQ=;
 b=oaiL4G1TDU6/JCSdZLXhY0Ac5oNdSR1qhTJ2ahZ/4aIhnMaD+eZ47Q4kqCkmTZor8T1G
 1PYoT4hkmPRyiV7d6bai9bBnlgznyyNf7z1fNkPB6Qo29fen3qx8OD02Esczw7KtoFzz
 DwATBV8pUqI9UjJrD44GRtIadkb9pWDeqgnifTz1L9zOwk6qXFkfe2btS26XYxKDcqTS
 GtuWZmv9Kh9voYEzOcNaKMGrLeAboAI4xhK0tNiIYLDwenhbL2n68xGfuMvEy28Rmkyl
 p+fIpjNrtIxmEuY+Jaa39mqgH/SgIBtx5IYTRREHLGRX5yL2CmevbYGv/q0Fyu1q3Xpx ZQ== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 31wxrn1p9j-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 03:23:09 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05U3IW0v065236;
        Tue, 30 Jun 2020 03:23:09 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3020.oracle.com with ESMTP id 31xfvrpwgp-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 03:23:09 +0000
Received: from abhmp0009.oracle.com (abhmp0009.oracle.com [141.146.116.15])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id 05U3N7No023576;
        Tue, 30 Jun 2020 03:23:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.156.108.201)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 03:23:06 +0000
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        Dan Carpenter <dan.carpenter@oracle.com>
Cc:     "Martin K . Petersen" <martin.petersen@oracle.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        linux-scsi@vger.kernel.org, kernel-janitors@vger.kernel.org,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        linux-samsung-soc@vger.kernel.org,
        Avri Altman <avri.altman@wdc.com>,
        linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Wei Yongjun <weiyongjun1@huawei.com>
Subject: Re: [PATCH] scsi: ufs: ufs-exynos: Remove an unnecessary NULL check
Date:   Mon, 29 Jun 2020 23:23:04 -0400
Message-Id: <159348736490.22355.10176976047581563338.b4-ty@oracle.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200626105133.GF314359@mwanda>
References: <20200626105133.GF314359@mwanda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 adultscore=0 spamscore=0
 phishscore=0 malwarescore=0 mlxlogscore=999 bulkscore=0 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300023
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9667 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 mlxlogscore=999
 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 malwarescore=0 phishscore=0 adultscore=0 cotscore=-2147483648
 lowpriorityscore=0 suspectscore=0 spamscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300023
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

On Fri, 26 Jun 2020 13:51:33 +0300, Dan Carpenter wrote:

> The "head" pointer can't be NULL because it points to an address in
> the middle of a ufs_hba struct.  Looking at this code, probably someone
> would wonder if the intent was to check whether "hba" is NULL, but "hba"
> isn't NULL and the check can just be removed.

Applied to 5.9/scsi-queue, thanks!

[1/1] scsi: ufs: ufs-exynos: Remove an unnecessary NULL check
      https://git.kernel.org/mkp/scsi/c/b7a80dac0f1f

-- 
Martin K. Petersen	Oracle Linux Engineering
