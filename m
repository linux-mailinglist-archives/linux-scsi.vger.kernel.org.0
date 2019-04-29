Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 74552E1B6
	for <lists+linux-scsi@lfdr.de>; Mon, 29 Apr 2019 13:59:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbfD2L7J (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Mon, 29 Apr 2019 07:59:09 -0400
Received: from aserp2130.oracle.com ([141.146.126.79]:48198 "EHLO
        aserp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727927AbfD2L7J (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Mon, 29 Apr 2019 07:59:09 -0400
Received: from pps.filterd (aserp2130.oracle.com [127.0.0.1])
        by aserp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TBsE9w180199;
        Mon, 29 Apr 2019 11:59:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=Kh86ADg5q1sSCox6JAJjCn6nPI721eo3NkgZqdYe8+A=;
 b=I+BoS6RBBipVgQc2twhZWt1b01D4Olx8Hj4dfjDcemDIT1PiCSa7UTRrH6up4OSV7xzb
 euAawLMMzVJfTsy5nMDOngUHM1XiY8WG/x0oZtS95wkc+sKhGMQvhomPsRNWpxJ9iTnz
 oWovzbORLQaK0GzBeMVpsiUDyCe2WA3vykkV128Bj1kuCPI1Ds+Dwz546g1aaN+QAUI/
 c+r6FDo71SVoArmi9awQK8Ees/AnsiY67rUftdIS4Qyg9YgYgiFzcTmmpOv/2XgdPGX6
 FY/0L6q+7shebK9KDfsCLu3FSNI/vlj0KTyUZ6Osm4VBKWVsP5NpoztjarGVNr5iNSMY bw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by aserp2130.oracle.com with ESMTP id 2s4ckd62xj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 11:59:05 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x3TBw74C111691;
        Mon, 29 Apr 2019 11:59:04 GMT
Received: from aserv0122.oracle.com (aserv0122.oracle.com [141.146.126.236])
        by userp3030.oracle.com with ESMTP id 2s4yy8x7fv-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Mon, 29 Apr 2019 11:59:04 +0000
Received: from abhmp0007.oracle.com (abhmp0007.oracle.com [141.146.116.13])
        by aserv0122.oracle.com (8.14.4/8.14.4) with ESMTP id x3TBx3Cw025185;
        Mon, 29 Apr 2019 11:59:03 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Mon, 29 Apr 2019 04:59:03 -0700
To:     Saurav Kashyap <skashyap@marvell.com>
Cc:     <martin.petersen@oracle.com>, <QLogic-Storage-Upstream@cavium.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 00/12] qedf: Changes to log messages
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <20190422054501.3224-1-skashyap@marvell.com>
Date:   Mon, 29 Apr 2019 07:59:01 -0400
In-Reply-To: <20190422054501.3224-1-skashyap@marvell.com> (Saurav Kashyap's
        message of "Sun, 21 Apr 2019 22:44:49 -0700")
Message-ID: <yq1v9yx10qi.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=756
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1810050000 definitions=main-1904290087
X-Proofpoint-Virus-Version: vendor=nai engine=5900 definitions=9241 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1015
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=792 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1810050000
 definitions=main-1904290087
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Saurav,

> This series improve the log messages to improve the debugging.

Applied to 5.2/scsi-queue, thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
