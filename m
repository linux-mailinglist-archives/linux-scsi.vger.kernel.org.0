Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id ECCF413EBC7
	for <lists+linux-scsi@lfdr.de>; Thu, 16 Jan 2020 18:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406139AbgAPRpP (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Thu, 16 Jan 2020 12:45:15 -0500
Received: from userp2130.oracle.com ([156.151.31.86]:45036 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406126AbgAPRpO (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Thu, 16 Jan 2020 12:45:14 -0500
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GHhM2U035551;
        Thu, 16 Jan 2020 17:45:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2019-08-05;
 bh=AljQ/NhiumK6kA+9Wc9w4HbMWFHvyBD05U5mYtzIXiI=;
 b=kULRKf1ml7UK6VQwd1eucYWDCxg2WDngWBQgvNClNI9rXtWg+mhwbkBSr9Wx+BA+3Flm
 7xDmu40GaLBvyiYW6l8i3wJ/5yV12kRHxDPDB8cGLY5ihYjFTI4lHNtAFDKDB6431XZE
 rHEnT1RHn1ppuPKNcMIIVsAOkMMNSNPk6EIcAUNK0Lsuq5XODFyV1agNNld8WDq0g6yr
 BfpbFBQwYyq02PQSEb8EZR9X5GkX0C3BW6AoNauf/kYHFigYWExbhQ3GYv17wfexIEuS
 +AD8Jj3LXVYstM572FA25qNw+Ga/4QlYKAu2PQItL/FIm6oD+nzTc4/m9sUzaKXiiWq2 mw== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2xf74sm1sk-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 17:45:12 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id 00GHi5rs079459;
        Thu, 16 Jan 2020 17:45:11 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 2xhy23r28v-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 16 Jan 2020 17:45:11 +0000
Received: from abhmp0014.oracle.com (abhmp0014.oracle.com [141.146.116.20])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 00GHjAnn011862;
        Thu, 16 Jan 2020 17:45:11 GMT
Received: from viboo.us.oracle.com (/10.132.94.91)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Thu, 16 Jan 2020 09:45:10 -0800
From:   Rajan Shanmugavelu <rajan.shanmugavelu@oracle.com>
To:     linux-scsi@vger.kernel.org, martin.petersen@oracle.com,
        srinivas.eeda@oracle.com, joe.jin@oracle.com,
        dick.kennedy@broadcom.com, laurie.barry@broadcom.com,
        james.smart@broadcom.com
Subject: Gather lpfc debug logs in kernel tracefs ringbuffer
Date:   Thu, 16 Jan 2020 09:44:24 -0800
Message-Id: <1579196665-13504-1-git-send-email-rajan.shanmugavelu@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=966
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1911140001 definitions=main-2001160143
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9502 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1911140001
 definitions=main-2001160143
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

    Having the lpfc debug logs inside a ring buffer enhances the driver to debug better/faster for hard to reproduce problem saving cyles.  Please review.

Thanks,
Rajan
Oracle Linux Engineering.

