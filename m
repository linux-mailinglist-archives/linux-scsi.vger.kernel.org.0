Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EDDF57A12
	for <lists+linux-scsi@lfdr.de>; Thu, 27 Jun 2019 05:34:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726820AbfF0Det (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Wed, 26 Jun 2019 23:34:49 -0400
Received: from userp2120.oracle.com ([156.151.31.85]:37326 "EHLO
        userp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726605AbfF0Det (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Wed, 26 Jun 2019 23:34:49 -0400
Received: from pps.filterd (userp2120.oracle.com [127.0.0.1])
        by userp2120.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R3Y2eE095746;
        Thu, 27 Jun 2019 03:34:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Liy+bgJ/bq+cZ2JVzjwPybpy3IkjiT35xUa4xNVgj58=;
 b=UzSvKfRK+OKFgMMftBlzFi459WYmuayaKMpI2erJ5W/k+tZ59PF0Sk+7rsB55SNjT/n3
 7ehOWiL4e1jVhENkbditBFiXu0QutlQuKI+IqjsnqPVLmTs37S1lVVPbOU/r7Mv3O7sB
 efhX0/vr2DzF4ppzv/kwnHwTlYlOwNvA31K7lKmDSbpbCTyZkDjSMtsTDeMRObm53Dof
 jyYI/opEd8ngV8Nju+vACo+cotY0eqyM72rl7hERDK0FW7rRcLujTZsi7wD4Gvdd+dks
 8vV+aBmhcxN7NcCXS3W4yJLtws7XkA3u7jDGGedzBzlxsoUDTW5TfRmD8yX0mnEBwabP 0g== 
Received: from aserp3030.oracle.com (aserp3030.oracle.com [141.146.126.71])
        by userp2120.oracle.com with ESMTP id 2t9cyqnkub-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 03:34:45 +0000
Received: from pps.filterd (aserp3030.oracle.com [127.0.0.1])
        by aserp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x5R3Ximf093835;
        Thu, 27 Jun 2019 03:34:44 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by aserp3030.oracle.com with ESMTP id 2t9acd14ws-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 27 Jun 2019 03:34:44 +0000
Received: from abhmp0006.oracle.com (abhmp0006.oracle.com [141.146.116.12])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x5R3YeOm015281;
        Thu, 27 Jun 2019 03:34:41 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Wed, 26 Jun 2019 20:34:40 -0700
To:     Deepak Ukey <deepak.ukey@microchip.com>
Cc:     <linux-scsi@vger.kernel.org>,
        <Vasanthalakshmi.Tharmarajan@microchip.com>,
        <Viswas.G@microcchip.com>, <jinpu.wang@profitbricks.com>,
        <martin.petersen@oracle.com>
Subject: Re: [PATCH 0/3] pm0xx : Updates for driver version 0.1.39.
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190624082228.27433-1-deepak.ukey@microchip.com>
Date:   Wed, 26 Jun 2019 23:34:38 -0400
In-Reply-To: <20190624082228.27433-1-deepak.ukey@microchip.com> (Deepak Ukey's
        message of "Mon, 24 Jun 2019 13:52:25 +0530")
Message-ID: <yq1pnmzk8fl.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=660
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1906270039
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9300 signatures=668687
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=727 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1906270039
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Deepak,

> This patch set include some bug fixes for pm80xx driver.

Applied patches 2 and 3 to 5.3/scsi-queue. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
