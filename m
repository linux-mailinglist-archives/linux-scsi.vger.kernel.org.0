Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA0C4273233
	for <lists+linux-scsi@lfdr.de>; Mon, 21 Sep 2020 20:48:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727782AbgIUSso (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 21 Sep 2020 14:48:44 -0400
Received: from aserp2120.oracle.com ([141.146.126.78]:52048 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727711AbgIUSso (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 21 Sep 2020 14:48:44 -0400
Received: from pps.filterd (aserp2120.oracle.com [127.0.0.1])
        by aserp2120.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LIj7OY036716;
        Mon, 21 Sep 2020 18:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=B79m6e6IhaS+UE6Gk2xOt4wjoYnGZnzBK1zjtLzVy+8=;
 b=WYrY4sJFbQdU2z/EaqiOEDhl8dFPit7rNyEYEOkHvfps2HyTZGBumj3m+ZC+QaG1H+Xz
 oGcuOiXfrZ3fVbNOhc9+zbL/xsJJgaG+Wg83qGw2wXiCO13e6RM29NUrRosY3iqeI05V
 OjDI0Z+QEK2aFCiS8QqqpYEO9j4zFTv6gCDokA/EFNk/qWhb73FaB92BdEvkNmnlJnjf
 j8g9kOKTEAYun67QUKKOs/YAXVS0jq2DhXg1DtkWryRiJdg4LfzZuzLao9Yqi+47maqR
 dx/CFSpxuqyW9GzU1DxFHfH14xiQDbLVFd9kX0pw2TqqJybxfO5CQFyuezV/SWGQHVBV 2w== 
Received: from userp3020.oracle.com (userp3020.oracle.com [156.151.31.79])
        by aserp2120.oracle.com with ESMTP id 33n9xkr2w4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 21 Sep 2020 18:48:40 +0000
Received: from pps.filterd (userp3020.oracle.com [127.0.0.1])
        by userp3020.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 08LIkJ8F173912;
        Mon, 21 Sep 2020 18:48:39 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3020.oracle.com with ESMTP id 33nurrag42-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 21 Sep 2020 18:48:39 +0000
Received: from abhmp0003.oracle.com (abhmp0003.oracle.com [141.146.116.9])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 08LImaIx030848;
        Mon, 21 Sep 2020 18:48:38 GMT
Received: from ol2.localdomain (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 21 Sep 2020 11:48:36 -0700
From:   Mike Christie <michael.christie@oracle.com>
To:     martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        james.bottomley@hansenpartnership.com
Subject: [PATCH 0/2] scsi/sd: make cmd retries configurable
Date:   Mon, 21 Sep 2020 13:48:27 -0500
Message-Id: <1600714109-6178-1-git-send-email-michael.christie@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 adultscore=0 malwarescore=0
 phishscore=0 mlxlogscore=917 bulkscore=0 mlxscore=0 suspectscore=0
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2006250000 definitions=main-2009210135
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9751 signatures=668679
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 priorityscore=1501 adultscore=0 spamscore=0 clxscore=1015
 mlxlogscore=933 bulkscore=0 mlxscore=0 phishscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2006250000
 definitions=main-2009210135
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The following patches made over Martin's 5.10 queue branch allow
the user to config sd cmd retries. I didn't allow the user to
set any old value and kept the max at 5. However, you can now
turn it off and rely on the transport error handler to decide
when to stop retrying. You can also decrease retries for cases
for disks where there is no use in retrying 5 times.

