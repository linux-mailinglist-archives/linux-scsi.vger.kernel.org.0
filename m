Return-Path: <linux-scsi-owner@vger.kernel.org>
X-Original-To: lists+linux-scsi@lfdr.de
Delivered-To: lists+linux-scsi@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A86057AE33
	for <lists+linux-scsi@lfdr.de>; Tue, 30 Jul 2019 18:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726510AbfG3QmY (ORCPT <rfc822;lists+linux-scsi@lfdr.de>);
        Tue, 30 Jul 2019 12:42:24 -0400
Received: from userp2130.oracle.com ([156.151.31.86]:36440 "EHLO
        userp2130.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726305AbfG3QmY (ORCPT
        <rfc822;linux-scsi@vger.kernel.org>); Tue, 30 Jul 2019 12:42:24 -0400
Received: from pps.filterd (userp2130.oracle.com [127.0.0.1])
        by userp2130.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UGd2xD032095;
        Tue, 30 Jul 2019 16:41:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=oracle.com; h=to : cc : subject :
 from : references : date : in-reply-to : message-id : mime-version :
 content-type; s=corp-2018-07-02;
 bh=oIwO59hUp/CL+1WXK/UtBzApd+3ZRaAirJ8LuIZuBu4=;
 b=hFzHOAZfhOpgS9sFiq2Fbwr68nv3I+a6YwFvOFAtNmqmH4Ya8xOmHHYruh5xT9XYwVzE
 pO16/VtTsSUSeusiSwMn6MO5lYZYd+nkhMqUhOWwuXJghGn6DWnxzmuzI6P3b2Cbfs6r
 OS6w12unLyk8SiwfI/6UfovCYedLtpjPVRgDxGm6HXiFLr7Or2FiLAobZIe7A8nk0+u6
 yiSVv9aOBHhjkZ0Kzxk0wtmY1vLYDut9ql9VUqC9I0HrpTCqMn+tk7+/usCPMWuvJ6jK
 BA/2cNDIOzW7QZsNfCfz1NgtjaGVc/wh2QorbMq2mprzyfoFtCB4Of5NxFLlg/3eM7pQ MQ== 
Received: from userp3030.oracle.com (userp3030.oracle.com [156.151.31.80])
        by userp2130.oracle.com with ESMTP id 2u0e1tqwu4-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 16:41:42 +0000
Received: from pps.filterd (userp3030.oracle.com [127.0.0.1])
        by userp3030.oracle.com (8.16.0.27/8.16.0.27) with SMTP id x6UGbuJ1165628;
        Tue, 30 Jul 2019 16:41:41 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userp3030.oracle.com with ESMTP id 2u0bqu9ejf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 30 Jul 2019 16:41:41 +0000
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.14.4/8.13.8) with ESMTP id x6UGfbh2002013;
        Tue, 30 Jul 2019 16:41:37 GMT
Received: from ca-mkp.ca.oracle.com (/10.159.214.123)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Tue, 30 Jul 2019 09:41:37 -0700
To:     Don Brace <don.brace@microsemi.com>
Cc:     <Kevin.Barnett@microchip.com>, <scott.teel@microchip.com>,
        <Justin.Lindley@microchip.com>, <scott.benesh@microchip.com>,
        <bader.alisaleh@microchip.com>, <gerry.morong@microchip.com>,
        <mahesh.rajashekhara@microchip.com>, <hch@infradead.org>,
        <jejb@linux.vnet.ibm.com>, <joseph.szczypek@hpe.com>,
        <POSWALD@suse.com>, <shunyong.yang@hxt-semitech.com>,
        <linux-scsi@vger.kernel.org>
Subject: Re: [PATCH 0/2] hpsa updates
From:   "Martin K. Petersen" <martin.petersen@oracle.com>
Organization: Oracle Corporation
References: <156400599822.14150.10317539253759491318.stgit@brunhilda>
Date:   Tue, 30 Jul 2019 12:41:34 -0400
In-Reply-To: <156400599822.14150.10317539253759491318.stgit@brunhilda> (Don
        Brace's message of "Wed, 24 Jul 2019 17:07:59 -0500")
Message-ID: <yq1r267mq4h.fsf@oracle.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1.92 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 suspectscore=0 malwarescore=0
 phishscore=0 bulkscore=0 spamscore=0 mlxscore=0 mlxlogscore=801
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.0.1-1906280000 definitions=main-1907300173
X-Proofpoint-Virus-Version: vendor=nai engine=6000 definitions=9334 signatures=668685
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 priorityscore=1501 malwarescore=0
 suspectscore=0 phishscore=0 bulkscore=0 spamscore=0 clxscore=1011
 lowpriorityscore=0 mlxscore=0 impostorscore=0 mlxlogscore=868 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.0.1-1906280000
 definitions=main-1907300173
Sender: linux-scsi-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-scsi.vger.kernel.org>
X-Mailing-List: linux-scsi@vger.kernel.org


Don,

> These patches are based on Linus's tree

Applied to 5.3/scsi-fixes. Thanks!

-- 
Martin K. Petersen	Oracle Linux Engineering
