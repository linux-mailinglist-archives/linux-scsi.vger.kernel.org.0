Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5228E2EA9B
	for <lists+linux-scsi@lfdr.de>; Thu, 30 May 2019 04:19:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727026AbfE3CTf (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 29 May 2019 22:19:35 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:53636 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726483AbfE3CTf (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 29 May 2019 22:19:35 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2J2EK189679;
        Thu, 30 May 2019 02:19:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=xueOnt0e9oxBY6PL3xRhqpuVeoCRtqJLkmZ29oYulNo=;
 b=vIZfUISLVRu/KMNicTc/YZvnp38Fj+xgt29GT9Sqf8G/L0042/6bkb/aeABxTRmVx+Jj
 75Pvd/kpJcrCHwBhK6NV3UhJdEDm4/LgWqjvn8zGVUz4t3RUHQqfpNlqdP95fHoRzYqa
 4QGGQNvYo0NM3jY3MWYe/eh4GypL3APJbOBqwuWrIFtP9UOogj/tw3Q1Qlhr7J+DMy29
 BJeY3/Dq6YZR7mSiZWR7Lhj0KG2mv4nlZDzbJ61dePrwklC82CoZdQMFvB7/32cNjDho
 RH0vjA5ik6m2HeS+1lUnBvDohb9s0sguEjx0Pxsh0O1Rx43TKtrrMGNdRjzl1uzw0pGK nA== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2spw4tncj0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:19:10 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x4U2IBtQ151150;
        Thu, 30 May 2019 02:19:09 GMT
Received: from userv0121.oracle.com (userv0121.oracle.com [156.151.31.72])
        by userp3030.oracle.com with ESMTP id 2ss1fnt4hs-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 30 May 2019 02:19:09 +0000
Received: from abhmp0011.oracle.com (abhmp0011.oracle.com [141.146.116.17])
        by userv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x4U2J79m027890;
        Thu, 30 May 2019 02:19:07 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 29 May 2019 19:19:07 -0700
To:     Stanley Chu <stanley.chu@mediatek.com>
Cc:     <linux-scsi@vger.kernel.org>, <martin.petersen@oracle.com>,
        <avri.altman@wdc.com>, <alim.akhtar@samsung.com>,
        <pedrom.sousa@synopsys.com>, <linux-mediatek@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>, <matthias.bgg@gmail.com>,
        <evgreen@chromium.org>, <beanhuo@micron.com>,
        <marc.w.gonzalez@free.fr>, <kuohong.wang@mediatek.com>,
        <peter.wang@mediatek.com>, <chun-hung.wu@mediatek.com>,
        <andy.teng@mediatek.com>
Subject: Re: [PATCH v5 0/3] scsi: ufs: Add error handling of Auto-Hibernate
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <1558421094-3182-1-git-send-email-stanley.chu@mediatek.com>
Date:   Wed, 29 May 2019 22:19:03 -0400
In-Reply-To: <1558421094-3182-1-git-send-email-stanley.chu@mediatek.com>
        (Stanley Chu's message of "Tue, 21 May 2019 14:44:51 +0800")
Message-ID: <yq1imtsy99k.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=939
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1905300016
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9272 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=981 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1905300016
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Stanley,

> Currently auto-hibernate is activated if host supports auto-hibern8
> capability. However error-handling is not implemented, which makes the
> feature somewhat risky.

Applied to 5.3/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
