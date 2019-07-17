Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 55D6B6B4B3
	for <lists+linux-scsi@lfdr.de>; Wed, 17 Jul 2019 04:49:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbfGQCsx (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 16 Jul 2019 22:48:53 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:34810 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725892AbfGQCsx (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 16 Jul 2019 22:48:53 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H2i9fm093863;
        Wed, 17 Jul 2019 02:48:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=pfGCIG//lwlpwIjnlmlEe0IcGWwFZvpDJ6SGAJb7E+w=;
 b=qZsedlFn0F6IGP7QFl6bBFglyV51VDvqKi7pBfG6u5OjCdoaFGROuj+vMMj5gAJWRPlg
 aBEQKFedTIHgfO4r9CvhI5dqRoMI1Ay5i355NQyjW4ZPwoZDpeVTUebX6cCe1OcYLPc1
 gGIWfMHgiUTaeKoOuNHzOtxCViIcMw7v0CqbXYYR2dsRwm7fw1ytwM7uEACBIhSmGKX8
 SuClFGmaZNvXJHLcm1IGfepBkjcDSEBJTFosB6fXCPI9wRgO83bNic8ZUXi+85yFKoB+
 lz5b4ogxkPW6+DJXQqMmHapUDtSB2xz3z70DoZsgAsVnQeWWxHzQfF6rU6LKwQjkBLxi AA== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by userp2120.oracle.com with ESMTP id 2tq7xqyrkq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 02:48:41 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6H2lQHF099298;
        Wed, 17 Jul 2019 02:48:41 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3020.oracle.com with ESMTP id 2tsmcc53va-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 17 Jul 2019 02:48:40 +0000
Received: from abhmp0018.oracle.com (abhmp0018.oracle.com [141.146.116.24])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x6H2mchj011067;
        Wed, 17 Jul 2019 02:48:38 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 17 Jul 2019 02:48:38 +0000
To:     "Bean Huo \(beanhuo\)" <beanhuo@micron.com>
Cc:     Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Pedro Sousa <pedrom.sousa@synopsys.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Evan Green <evgreen@chromium.org>,
        Stanley Chu <stanley.chu@mediatek.com>,
        "linux-kernel\@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-scsi\@vger.kernel.org" <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH v1] scsi: ufs: change msleep to usleep_range
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <BN7PR08MB5684BBB44FD0E43501558A20DBCF0@BN7PR08MB5684.namprd08.prod.outlook.com>
Date:   Tue, 16 Jul 2019 22:48:35 -0400
In-Reply-To: <BN7PR08MB5684BBB44FD0E43501558A20DBCF0@BN7PR08MB5684.namprd08.prod.outlook.com>
        (Bean Huo's message of "Mon, 15 Jul 2019 11:21:10 +0000")
Message-ID: <yq136j5z88s.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=867
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1907170033
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9320 signatures=668688
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=913 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1907170032
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Bean,

> This patch is to change msleep() to usleep_range() based on
> Documentation/timers/timers-howto.txt. It suggests using
> usleep_range() for small msec(1ms - 20ms) since msleep() will often
> sleep longer than desired value.

Applied to 5.4/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
