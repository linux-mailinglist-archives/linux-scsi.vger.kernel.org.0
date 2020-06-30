Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 82DE821007D
	for <lists+linux-scsi@lfdr.de>; Wed,  1 Jul 2020 01:35:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726777AbgF3Xfu (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jun 2020 19:35:50 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:45572 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgF3Xfu (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jun 2020 19:35:50 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UNVK5E138094;
        Tue, 30 Jun 2020 23:35:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=from : to : subject :
 date : message-id; s=corp-2020-01-29;
 bh=2j+E2s3l/0zjp1Yerexg4CEg3z4YCSYxz7bX06THGqA=;
 b=cQXWdNphAAf/dF4k6NP5S70eZn5Be7FbfkcgngPmeSB1kMk0JlZvNOysUfUFxrkzsAKx
 jMkggtniAXJPd2IcoXxaqnL0YjPYLs0WpDGxcuwRArqbF7KIS6ds0FKD5YOvgk8YO2yP
 ddv2fwN+cMFAKzBs+RCUid+ldYrKdOgoFVS49hqxF+3bAx8DXEvj9nBlVUhfQ5l1Dx/K
 tr1OgCtCjpT8OntBCdHX0iwMcEAjv8UqtAyPhu7rLYr/7Rhjq26mYGrASHWuiOtKz41F
 9T8HxbarFnbJz+5zRWjObULjwitM4Ft1+6hzTg5Z9rEb0gq8932ZJtOtHlUtW3jXBzi/ Bg== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 31ywrbnm6x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 30 Jun 2020 23:35:41 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.42/8.16.0.42) with SMTP id 05UNXmT7069852;
        Tue, 30 Jun 2020 23:35:41 GMT
Received: from userv0122.oracle.com (userv0122.oracle.com [156.151.31.75])
        by userp3030.oracle.com with ESMTP id 31xg1xgfn6-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jun 2020 23:35:41 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by userv0122.oracle.com (8.14.4/8.14.4) with ESMTP id 05UNZZJP002860;
        Tue, 30 Jun 2020 23:35:40 GMT
Received: from ol2.localdomain (/73.88.28.6)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jun 2020 23:35:35 +0000
From:   Mike Christie <michael.christie@oracle.com>
To:     cleech@redhat.com, lduncan@suse.com, martin.petersen@oracle.com,
        linux-scsi@vger.kernel.org, james.bottomley@hansenpartnership.com
Subject: [PATCH 0/4] iscsi fixes/cleanups 
Date:   Tue, 30 Jun 2020 18:35:30 -0500
Message-Id: <1593560134-28148-1-git-send-email-michael.christie@oracle.com>
X-Mailer: git-send-email 1.8.3.1
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9668 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 phishscore=0
 malwarescore=0 mlxlogscore=999 adultscore=0 mlxscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2004280000
 definitions=main-2006300163
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9668 signatures=668680
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 bulkscore=0 spamscore=0 mlxlogscore=999
 clxscore=1015 cotscore=-2147483648 priorityscore=1501 lowpriorityscore=0
 malwarescore=0 mlxscore=0 adultscore=0 suspectscore=0 impostorscore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2004280000 definitions=main-2006300163
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org

The following patches were made over Martin's 5.8 fixes branches.

The first patch:

[PATCH 1/4] iscsi class: make sure the block/recovery work are done

fixes a regression that was just added in 5.8-rc1 with commit:

commit 3ce419662dd4c9cf8db7869c4972ad51ccdf2ee3
Author: Bob Liu <bob.liu@oracle.com>
Date:   Tue May 5 09:19:08 2020 +0800

    scsi: iscsi: Register sysfs for iscsi workqueue

so it should go into 5.8-rc. With that patch we allow multple works
to be run in parallel so it broke some assumtions the iscsi class
was making.

The other patches can just go into next. They are not critical.

